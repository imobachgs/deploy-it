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
  after_commit :broadcast_deployment

  serialize :configuration, Hash

  delegate :name, to: :project, prefix: true
  delegate :name, to: :status, prefix: true

  scope :unfinished, -> do
    where.not(status_id: [DeploymentStatus::SUCCESS.id, DeploymentStatus::FAILED.id])
  end

  # Check if is finished
  #
  # @return [Boolean] true if has a failed or success status; false otherwise.
  def finished?
    [DeploymentStatus::FAILED, DeploymentStatus::SUCCESS].include?(status)
  end

  # Check if is still active
  #
  # @see #finished?
  #
  # @return [Boolean] true if is not finished; false otherwise.
  def unfinished?
    !finished?
  end

  # Enqueue a deploy job for each machine in the project
  #
  # Machine deployments can be enqueued only once.
  def build_queue
    raise AlreadyInQueue unless machine_deployments.empty?
    ordered = project.assignments.sort_by(&:role_id)
    ordered.chunk(&:machine_id).each do |machine_id, assignments|
      machine_deployments.create(machine_id: machine_id, roles: assignments.map(&:role).map(&:chef))
    end
  end

  def next!
    # FIXME: we should not trust in the id to order the deployments
    machine_deployments.pending.order(:id).first
  end

  def update_status!
    self.status =
      if machine_deployments.all?(&:successful?)
        DeploymentStatus::SUCCESS
      elsif machine_deployments.any?(&:failed?)
        DeploymentStatus::FAILED
      elsif machine_deployments.any?(&:running?)
        DeploymentStatus::RUNNING
      else
        DeploymentStatus::PENDING
      end
    save
  end

protected

  def set_configuration
    klass = "DeployIt::Configurators::#{project.type.sub(/Project\Z/, '')}".constantize
    self.configuration = klass.new(project).to_hash
  end

  def set_default_status
    self.status_id ||= DeploymentStatus::PENDING.id
  end

  def broadcast_deployment
    DeploymentBroadcastJob.perform_later(status.name, user: project.user)
  end
end

# == Schema Information
#
# Table name: deployments
#
#  id            :integer          not null, primary key
#  project_id    :integer
#  status_id     :integer          not null
#  configuration :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_deployments_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_b9a3851b82  (project_id => projects.id)
#
