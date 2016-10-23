# Represents a database adapter of {Project}

class RailsAdapter < ActiveHash::Base

  self.data = [
    { id: 1, name: 'Postgresql', adapter: 'pg' },
    { id: 2, name: 'Mysql', adapter: 'mysql' }
  ]

end
