require 'rails_helper'

RSpec.describe MachineDeployment, type: :model do
  it { is_expected.to validate_presence_of :deployment_id }
  it { is_expected.to validate_presence_of :status_id }

  it { is_expected.to belong_to :deployment }
end
