module DeployIt
  module Configurators
    class Rails
      attr_reader :project

      def initialize(project)
        @project = project
      end

      def to_hash
        {
          postgresql: {
            password: {
              postgres: project.db_admin_password
            }
          },
          deploy_it: {
            database: {
              database: project.database_name,
              username: project.database_username,
              password: project.database_password,
              adapter:  project.database_adapter,
              host: project.machine_with_role(RailsRole::DATABASE).ip
            },
            path: "/srv/app-#{project.id}",
            repo_url: project.repo_url,
            secret: project.secret
          },
        }
      end
    end
  end
end
