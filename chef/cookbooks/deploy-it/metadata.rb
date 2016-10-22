name 'deploy-it'
maintainer 'GDMK'
maintainer_email 'imobachgs@gmail.com'
license 'mit'
description 'Deploys applications'
long_description 'Deploys different kinds of applications'
version '0.1.0'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
# issues_url 'https://github.com/<insert_org_here>/deploy-it/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
# source_url 'https://github.com/<insert_org_here>/deploy-it' if respond_to?(:source_url)
depends "application"
depends "application_ruby"
depends "application_git"
depends "postgresql"
depends "database"
