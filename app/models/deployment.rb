# Configuration deployment
class Deployment < ApplicationRecord
  # The deployment is already in the queue.
  class AlreadyInQueue < StandardError; end

  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :project
  belongs_to :status, class_name: 'DeployStatus'
  has_many :machine_deployments

  validates :project_id, :status_id, presence: true

  after_create :queue_up
  before_create { |d| d.status_id = DeplyStatus::PENDING.id }

  # Enqueue the deploy job for each machine in the project
  #
  # Machine deployments can be enqueued only once per deploy.
  def queue_up
    raise AlreadyInQueue unless machine_deployments.empty?
  end
end
