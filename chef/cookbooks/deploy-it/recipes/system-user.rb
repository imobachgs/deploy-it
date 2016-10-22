#
# cookbook name:: deploy-it
# recipe:: system-user
#
# copyright (c) 2016 gdmk, mit license

#
# Create a system user to be used in the deploy
#
group node['deploy-it']['system']['user'] do
  action :create
end

user node['deploy-it']['system']['user'] do
  username node['deploy-it']['system']['user']
  group node['deploy-it']['system']['user']
  system true
  action :create
end
