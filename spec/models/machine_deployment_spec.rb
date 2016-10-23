require 'rails_helper'

RSpec.describe MachineDeployment, type: :model do
  it { is_expected.to validate_presence_of :deployment_id }
  it { is_expected.to validate_presence_of :status_id }

  it { is_expected.to belong_to :deployment }
end

# == Schema Information
#
# Table name: machine_deployments
#
#  id            :integer          not null, primary key
#  deployment_id :integer
#  machine_id    :integer
#  status_id     :integer          not null
#  log           :text
#  roles         :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_machine_deployments_on_deployment_id  (deployment_id)
#  index_machine_deployments_on_machine_id     (machine_id)
#  index_machine_deployments_on_status_id      (status_id)
#
# Foreign Keys
#
#  fk_rails_15310c13ce  (deployment_id => deployments.id)
#  fk_rails_922946b9a1  (machine_id => machines.id)
#
