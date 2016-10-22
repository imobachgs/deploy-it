#
# Cookbook Name:: deploy-it
# Recipe:: rails
#
# Copyright (c) 2016 GDMK, MIT License

# Extract the database type
case node['deploy-it']['database']['adapter']
when 'postgresql'
  include_recipe 'deploy-it::postgresql'
when 'mysql'
  include_recipe 'deploy-it::mysql'
end
