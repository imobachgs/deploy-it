class DeploymentJob < ApplicationJob
  queue_as :default

  def perform(deployment_id)
    deployment = Deployment.find(deployment_id)
    machine_deployment = deployment.next!
    return if machine_deployment.nil?
    Deployer.new(machine_deployment).deploy
    DeploymentJob.perform_later(deployment.id)
  end
end
