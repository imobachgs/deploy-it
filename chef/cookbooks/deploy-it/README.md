# deploy-it

This cookbook contains some recipes to deploy simple applications. It was developed as
part of the [Deploy it!](https://github.com/rumblex/rubyrampage2016-deploy-it) during the
Ruby Rampage 2016.

For the time being, only Ruby on Rails applications are supported.

## Deploying a Ruby on Rails application

Create a JSON file containig the application description (for example `deploy.json`):

```json
{
  "postgresql": {
    "password": {
      "postgres": "secret"
    }
  },
  "deploy-it": {
    "database": {
      "database": "myapp",
      "username": "rails",
      "password": "myrails",
      "adapter": "postgresql",
      "host": "localhost"
    },
    "path": "/srv/deploy-app",
    "repo_url": "https://github.com/its-me/my-cool-app"
  }
}
```

Create and configure the database:

    sudo chef-client --local-mode --config=client.rb -j deploy.json \
      --runlist 'deploy-it::database'
    
And finally deploy your Ruby on Rails application:

    sudo chef-client --local-mode --config=client.rb -j deploy.json \
      --runlist 'deploy-it::rails'
