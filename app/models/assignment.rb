class Assignment < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :project
  belongs_to :machine

  def role
    project.kind.roles.find { |r| r.id == role_id }
  end
end
