require 'rails_helper'

RSpec.describe Deployment, type: :model do
  it { is_expected.to validate_presence_of :project_id }
  it { is_expected.to validate_presence_of :status_id }

  it { is_expected.to have_many :machine_deployments }
  it { is_expected.to belong_to :project }
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
