# Represents a type of {Project}

class ProjectKind < ActiveHash::Base
  self.data = [
    { id: 1, name: 'Rails' }
  ]
end
