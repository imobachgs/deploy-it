#
# Cookbook Name:: deploy-it
# Recipe:: rails
#
# Copyright (c) 2016 GDMK, MIT License

#
# Create system user
#
group node['deploy-it']['rails']['user'] do
  action :create
end

user node['deploy-it']['rails']['user'] do
  username node['deploy-it']['rails']['user']
  group node['deploy-it']['rails']['user']
  system true
  action :create
end

node.override["build-essential"]["compile_time"] = true
include_recipe 'build-essential::default'

ruby_runtime node['deploy-it']['ruby']['version']

package 'database libraries' do
  case node['deploy-it']['database']['adapter']
  when 'postgresql'
    package_name 'libpq-dev'
  when 'mysql'
    package_name 'libmysqlclient-dev'
  end
end

application node['deploy-it']['path'] do
  owner node['deploy-it']['rails']['user']
  group node['deploy-it']['rails']['user']

  git node['deploy-it']['repo_url'] do
    user 'rails'
    group 'rails'
  end

  bundle_install do
    user node['deploy-it']['rails']['user']
    deployment true
    without %w{development test}
  end

  rails do
    db = node['deploy-it']['database']
    database "#{db['adapter']}://#{db['username']}:#{db['password']}@#{db['host']}/#{db['database']}"
    secret_token node['deploy-it']['rails']['secret']
    migrate true
  end

  unicorn do
    user node['deploy-it']['user']
    port node['deploy-it']['port']
  end
end
