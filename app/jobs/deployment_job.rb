class DeploymentJob < ApplicationJob
  queue_as :default

  def perform(deployment)
    machine_deployment = deployment.next!
    return if machine_deployment.nil?
    Deployer.new(machine_deployment).deploy
    DeploymentJob.perform_later(deployment)
  end
end
