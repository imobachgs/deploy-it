require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DeployIt
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Generators
    config.generators do |g|
      g.assets false
      g.helper false
      g.view_specs false
      g.controller_specs false
    end

    config.active_job.queue_adapter = :sidekiq

    # Eager load lib directory
    config.eager_load_paths << Rails.root.join('lib')
  end
end
