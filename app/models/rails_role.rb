# Represents the {Role} of the `application`

class RailsRole < ActiveHash::Base

  self.data = [
    { id: 1, name: 'Application' },
    { id: 2, name: 'Database' }
  ]
end
