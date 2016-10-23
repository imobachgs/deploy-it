# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class DeploymentChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
