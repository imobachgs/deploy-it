#
# Cookbook Name:: deploy-it
# Recipe:: postgresql
#
# Copyright (c) 2016 GDMK, MIT License

# Deploy a PostgreSQL server and create a database to be used by the
# application.
#
# In an ideal world, using `database_user` and `postgresql_database`
# resources should be the way to go. Unfortunatelly, we were struggling
# with http://www.mandsconsulting.com/vagrant-chef-installed-via-omnibus-and-the-postgresql-and-database-cookbooks-re-cook-1406
# without success, so we decided to use the shell to create the database
# and user.

# config: {
#   listen_addresses: "localhost,#{database_ip}"
# },
node.default['postgresql']['config']['listen_addresses'] =
  "localhost,#{node['deploy-it']['database']['host']}"

node.default['postgresql']['pg_hba'] += [
  { :type => 'host', :db => 'all', :user => 'all',
    :addr => "#{node['deploy-it']['rails']['host']}/32", :method => 'md5' },
]
include_recipe "postgresql::server"

execute "create application user" do
  user "postgres"
  command "createuser #{node['deploy-it']['database']['username']}"
  ignore_failure true
  sensitive true
end

execute "update application user password" do
  user "postgres"
  command "psql -c \"ALTER USER #{node['deploy-it']['database']['username']} WITH " \
    "PASSWORD '#{node['deploy-it']['database']['password']}'\""
  sensitive true
end

execute "create application database" do
  user "postgres"
  command "createdb -O #{node['deploy-it']['database']['username']} " \
    "#{node['deploy-it']['database']['database']}"
  not_if "psql -lqt | cut -d \\| -f 1 | " \
    "grep -qw #{node['deploy-it']['database']['database']}"
end
