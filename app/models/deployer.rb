colass Deployer

  attr_reader :machine, :config, :user, :key

  def initialize(host, user, key, config)
    @host = host
    @user = user
    @key = key
    @config = config
  end

  def deploy
    prepare_machine
  end

  INSTALL_CHEF_CMD = "curl https://omnitruck.chef.io/install.sh | sudo bash " \
    "-s -- -P chefdk -c stable -v 0.19.6"
  def prepare_machine
    # connect and deploy chef
    run_ssh do |ssh|
      ssh.exec!(INSTALL_CHEF)
    end
  end

  COOKBOOKS_LOCAL_PATH = Rails.root.join("chef")
  COOKBOOKS_REMOTE_PATH = "/opt/deploy-it"
  def prepare_cookbook
    copy_ssh do |scp|
      scp.upload! COOKBOOKS_LOCAL_PATH, COOKBOOKS_REMOTE_PATH
      scp.upload! config_file, File.join(COOKBOOKS_REMOTE_PATH, "config.json")
    end
  end

  DEPLOY_CMD
  def run_cookbook
    # run chef recipes
  end

  def run_ssh
    retval = nil
    Net::SSH.start(host, user, key_data: key, keys_only: true) do |ssh|
      ssh.on_request('exit-status') do |_ch, dt|
        retval = dt.read_long
      end

      yield ssh
    end
    retval.zero?
  end

  def copy_ssh
    Net::SSH.start(host, user, key_data: key, keys_only: true) do |ssh|
      yield scp
    end
  end
end
