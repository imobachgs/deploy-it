require 'rails_helper'

RSpec.describe Assignment, type: :model do
  it { should belong_to(:project) }
  it { should belong_to(:machine) }
  it { should belong_to(:role) }
end
