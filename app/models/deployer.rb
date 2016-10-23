require "pathname"
require "net/ssh"

class Deployer
  attr_reader :host, :user, :config, :roles

  def initialize(host, user, config, roles)
    @host = host
    @user = user
    @config = config
  end

  def deploy
    upload_cookbook
    install_chef
    run_cookbook
  end

  INSTALL_CHEF_CMD = "curl https://omnitruck.chef.io/install.sh | sudo bash " \
    "-s -- -P chefdk -c stable -v 0.19.6"
  def install_chef
    # connect and deploy chef
    run_ssh do |ssh|
      ssh.exec!(INSTALL_CHEF_CMD)
    end
  end

  COOKBOOKS_LOCAL_PATH = Rails.root.join("chef").freeze
  COOKBOOKS_REMOTE_PATH = Pathname("/var/tmp/deploy-it").freeze
  def upload_cookbook
    config_file = Tempfile.new("deploy-it-config")
    puts config_file.path
    copy_ssh do |scp|
      #scp.upload! COOKBOOKS_LOCAL_PATH, COOKBOOKS_REMOTE_PATH, recursive: true
      byebug
      scp.upload! config_file.path, COOKBOOKS_REMOTE_PATH.join("config.json")
    end
  ensure
    config_file.close
    config_file.unlink
  end

  DEPLOY_CMD = "cd %{path} && chef-client --local-mode --config client.rb -j config.json " \
    "--runlist '%{runlist}}'"
  def run_cookbook
    # run chef recipes
    runlist = roles.map { |r| "recipe[deploy-it::#{r}]" }.join(",")
    cmd = format(DEPLOY_CMD, path: COOKBOOKS_REMOTE_PATH.to_s, runlist: runlist)
  end

  def run_ssh
    retval = nil
    Net::SSH.start(host, "root", key_data: user.private_key, keys_only: true) do |ssh|
      ssh.on_request('exit-status') do |_ch, dt|
        retval = dt.read_long
      end

      yield ssh
    end
    retval.zero?
  end

  def copy_ssh
    Net::SCP.start(host, "root", key_data: user.private_key, keys_only: true) do |scp|
      yield scp
    end
  end
end
