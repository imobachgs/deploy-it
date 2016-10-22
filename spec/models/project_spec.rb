require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should belong_to(:kind).class_name('ProjectKind') }
  it { should belong_to :user }
  it { should have_many(:assignments) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:repo_url) }
end
