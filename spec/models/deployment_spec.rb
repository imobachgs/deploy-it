require 'rails_helper'

RSpec.describe Deployment, type: :model do
  it { is_expected.to validate_presence_of :project_id }
  it { is_expected.to validate_presence_of :status_id }

  it { is_expected.to have_many :machine_deployments }
  it { is_expected.to belong_to :project }
end
