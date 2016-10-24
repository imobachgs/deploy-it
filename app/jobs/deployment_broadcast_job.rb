class DeploymentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(status, user:)
    DeploymentChannel.broadcast_to user, status: status
  end
end
