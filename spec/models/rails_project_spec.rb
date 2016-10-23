require 'rails_helper'

RSpec.describe RailsProject, type: :model do
  %i(ruby_version database_adapter database_name database_username
     database_password).each do |attr|
    it { is_expected.to validate_presence_of(attr).on(:update) }
  end


  describe 'secret attribute'
    it 'must have a value before save' do
    project = described_class.new(secret: nil)
    project.validate

    expect(project.secret).to_not be_nil
  end

  describe ".roles" do
    it "returns all Rails roles" do
      expect(described_class.roles).to eq(RailsRole.all)
    end
  end
end
