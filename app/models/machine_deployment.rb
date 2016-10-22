class MachineDeployment < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :deployment
  belongs_to :status, class_name: 'DeployStatus'

  validates :deployment_id, :status_id, presence: true
end
