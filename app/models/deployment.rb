# Configuration deployment
class Deployment < ApplicationRecord
  # The deployment is already in the queue.
  class AlreadyInQueue < StandardError; end

  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :project
  belongs_to :status, class_name: 'DeploymentStatus'
  has_many :machine_deployments

  validates :project_id, :status_id, presence: true

  before_create :set_configuration
  after_initialize :set_default_status
  after_create :build_queue

  # Enqueue a deploy job for each machine in the project
  #
  # Machine deployments can be enqueued only once.
  def build_queue
    raise AlreadyInQueue unless machine_deployments.empty?
    ordered = project.assignments.sort_by(&:role_id)
    ordered.chunk(&:machine_id).each do |machine_id, assignments|
      byebug
      machine_deployments.create(machine_id: machine_id, roles: assignments.map(&:role).map(&:chef))
    end
  end

  def next!
    next_deploy = machine_deployments.find_by_status_id(DeployStatus::PENDING.id)
    if next_deploy.nil? # Finished!
      update_attributes!(status: DeployStatus::FINISHED)
    else
      update_attributes!(status: DeployStatus::RUNNING)
      # Perform job
    end
  end

protected

  def set_configuration
    klass = "DeployIt::Configurators::#{project.type.sub(/Project\Z/, '')}".constantize
    self.configuration = klass.new(project).to_hash
  end

  def set_default_status
    self.status_id ||= DeploymentStatus::PENDING.id
  end
end
