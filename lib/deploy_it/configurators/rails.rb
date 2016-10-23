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
          "deploy-it" => {
            database: {
              database: project.database_name,
              username: project.database_username,
              password: project.database_password,
              adapter:  project.database_adapter,
              host: project.machine_with_role(RailsRole::DATABASE).ip
            },
            rails: {
              host: project.machine_with_role(RailsRole::APPLICATION).ip,
              secret: project.secret
            },
            path: "/srv/app-#{project.id}",
            repo_url: project.repo_url,
            port: project.port,
          },
        }
      end
    end
  end
end
