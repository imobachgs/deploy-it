require 'rails_helper'

RSpec.describe Assignment, type: :model do
  it { should belong_to(:project) }
  it { should belong_to(:machine) }
end

# == Schema Information
#
# Table name: assignments
#
#  id         :integer          not null, primary key
#  project_id :integer          not null
#  machine_id :integer          not null
#  role_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
