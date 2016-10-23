# Represents a type of {Project}

class ProjectKind < ActiveHash::Base

  self.data = [
    { id: 1, name: 'Rails' }
  ]

  def roles
    Module.const_get("#{name}Role").all
  end

  def adapters
    Module.const_get("#{name}Adapter").all
  end
end
