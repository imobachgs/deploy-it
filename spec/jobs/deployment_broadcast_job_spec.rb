require 'rails_helper'

RSpec.describe DeploymentBroadcastJob, type: :job do
  before do
    ActiveJob::Base.queue_adapter = :test
  end

  it "matches with enqueued job" do
    described_class.perform_later

    expect(described_class).to have_been_enqueued.on_queue('default')
  end

  describe '#perfom(status, user:)' do
    it 'broadcasts expected message' do
      expect(DeploymentChannel).to receive(:broadcast_to)

      described_class.perform_now('pending', user: instance_double('User'))
    end
  end
end
