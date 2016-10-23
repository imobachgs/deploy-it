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

# == Schema Information
#
# Table name: assignments
#
#  id         :integer          not null, primary key
#  project_id :integer          not null
#  machine_id :integer          not null
#  role_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
