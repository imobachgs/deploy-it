# Represents a rol of a {Machine} in a {Project}

class Role < ActiveHash::Base
  self.data = [
    { id: 1, name: 'Application' },
    { id: 2, name: 'Database' }
  ]
end
