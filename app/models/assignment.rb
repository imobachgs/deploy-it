class Assignment < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :project
  belongs_to :machine

  delegate :name, to: :project, prefix: true
  delegate :name, to: :machine, prefix: true

  def role
    project.kind.roles.find { |r| r.id == role_id }
  end
end
