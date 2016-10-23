# Represents the {Role} of the `application`

class RailsRole < ActiveHash::Base
  include ActiveHash::Enum

  self.data = [
    { id: 1, name: 'Database', chef: 'database' },
    { id: 2, name: 'Application', chef: 'rails' }
  ]

  enum_accessor :name
end
