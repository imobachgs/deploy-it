class DeployBroadcastJob < ApplicationJob
  queue_as :default

  def perform(log)
    ActionCable.server.broadcast "deployer", { content: render_message(log) }
  end

  private

  def render_message(message)
    # DeployerController.render(partial: 'deploy_content', locals: { content: log}).squish
  end
end
