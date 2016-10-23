require "net/ssh"
require "net/scp"

# Orchestate the deployment
#
# These are the steps taken to do the deployment:
#
# * Install chefdk if it's not available
# * Upload cookbooks and configuration (runlist, variables, etc.)
# * Copy deployment configuration
#
# There's a lot of room for improvement in this class.
#
# * Handle error nicely.
# * Minimize the number of SSH connections.
#
# @see #deploy
class Deployer
  attr_reader :machine_deployment, :host, :user, :config, :roles

  CHEFDK_VERSION = "0.19.6"
  REMOTE_WORKSPACE_PATH = "/var/tmp/deploy-it".freeze
  INSTALL_CHEF_CMD = "curl https://omnitruck.chef.io/install.sh | sudo bash " \
    "-s -- -P chefdk -c stable -v #{CHEFDK_VERSION}"
  COOKBOOKS_PATH = Rails.root.join("chef/cookbooks.tar.gz").to_s.freeze
  REMOTE_COOKBOOKS_PATH = File.join(REMOTE_WORKSPACE_PATH, "cookbooks.tar.gz").freeze
  DEPLOY_CMD = "cd %{path} && chef-client --local-mode --config cookbooks/client.rb -j config.json " \
    "--runlist '%{runlist}'"

  # Construtor
  #
  # @param [MachineDeployment] Deployment to perform
  def initialize(machine_deployment)
    @machine_deployment = machine_deployment
    @host = machine_deployment.machine.ip
    @user = machine_deployment.deployment.project.user
    @config = machine_deployment.deployment.configuration
    @roles = machine_deployment.roles
  end

  # Deploy the application
  def deploy
    set_status(:running)
    prepare_server
    upload_configuration
    if run_cookbook
      set_status(:successful)
    else
      set_status(:failed)
    end
  rescue
    set_status(:failed)
  end

  # Set machine_deployment status
  def set_status(status)
    machine_deployment.send("set_as_#{status}!")
    machine_deployment.deployment.update_status!
    # We could send the notification here
  end

  # Prepare the server to perform the deploy
  #
  # * Install ChefDK in case it's not available.
  # * Clean-up the workspace
  def prepare_server
    run_ssh do |ssh|
      unless exec_and_log(ssh, "chef env | grep -qw 'ChefDK Version: #{CHEFDK_VERSION}'")
        exec_and_log(ssh, INSTALL_CHEF_CMD)
      end
      ssh.exec!("rm -rf #{REMOTE_WORKSPACE_PATH}")
      ssh.exec!("mkdir -p #{REMOTE_WORKSPACE_PATH}")
    end
  end

  # Upload the cookbooks and the configuration to be used
  def upload_configuration
    config_file = Tempfile.new("deploy-it-config")
    config_file.write(config.to_json)
    config_file.close

    copy_ssh do |scp|
      scp.upload! config_file.path, File.join(REMOTE_WORKSPACE_PATH, "config.json")
      scp.upload! COOKBOOKS_PATH, REMOTE_COOKBOOKS_PATH
    end
  ensure
    config_file.unlink
  end

  # Apply the configuration
  def run_cookbook
    result = nil
    runlist = roles.map { |r| "recipe[deploy-it::#{r}]" }.join(",")
    cmd = format(DEPLOY_CMD, path: REMOTE_WORKSPACE_PATH, runlist: runlist)
    run_ssh do |ssh|
      exec_and_log(ssh, "rm -rf #{File.join(REMOTE_WORKSPACE_PATH, "cookbooks")}")
      exec_and_log(ssh, "tar xf #{REMOTE_COOKBOOKS_PATH} -C #{REMOTE_WORKSPACE_PATH}")
      result = exec_and_log(ssh, cmd)
    end
    result
  end

  # Execute a command through SSH and log the output
  #
  # @param ssh [Net::SSH::Connection::Session] SSH session.
  # @param cmd [String]                        Command to execute.
  # @return [Boolean] True if the command was successful; false otherwise.
  def exec_and_log(ssh, cmd)
    exit_status = 0
    ssh.exec!(cmd) do |channel, _stream, data|
      append_to_log(data)
      channel.on_request('exit-status') do |_ch, dt|
        exit_status = dt.read_long
      end
    end
    success = exit_status.zero?
    append_to_log("'#{cmd}' failed")
    success
  end

  # Append text to the deployment's log
  #
  # @see MachineDeployment#append_to_log
  def append_to_log(text)
    machine_deployment.append_to_log(text)
  end

  # Helper method to run commands in the target machine
  def run_ssh
    Net::SSH.start(host, "root", key_data: user.private_key_as_text, keys_only: true) do |ssh|
      yield ssh
    end
  end

  # Helper method to copy files to the target machine
  def copy_ssh
    Net::SCP.start(host, "root", key_data: user.private_key_as_text, keys_only: true) do |scp|
      yield scp
    end
  end
end
