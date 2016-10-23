class MachineDeployment < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :deployment
  belongs_to :machine
  belongs_to :status, class_name: 'DeploymentStatus'

  serialize :roles, Array

  scope :pending, -> { where(status_id: DeploymentStatus::PENDING.id) }

  after_initialize :set_default_status

  validates :deployment_id, :status_id, presence: true

  delegate :name, to: :machine, prefix: true

  def append_to_log(text)
    self.class.where(id: id).update_all(["log = log || ?", text])
  end

  def set_as_running!
    update_attributes!(started_at: Time.zone.now, status_id: DeploymentStatus::RUNNING.id)
  end

  def set_as_successful!
    update_attributes!(finished_at: Time.zone.now, status_id: DeploymentStatus::SUCCESS.id)
  end

  def set_as_failed!
    update_attributes!(finished_at: Time.zone.now, status_id: DeploymentStatus::FAILED.id)
  end

  def pending?
    status == DeploymentStatus::PENDING
  end

  def running?
    status == DeploymentStatus::RUNNING
  end

  def successful?
    status == DeploymentStatus::SUCCESS
  end

  def failed?
    status == DeploymentStatus::FAILED
  end

  protected

  def set_default_status
    self.status ||= DeploymentStatus::PENDING
  end
end
