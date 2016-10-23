# Represents the {Role} of the `application`

class RailsRole < ActiveHash::Base
  include ActiveHash::Enum

  self.data = [
    { id: 1, name: 'Application' },
    { id: 2, name: 'Database' }
  ]

  enum_accessor :name
end
