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

# == Schema Information
#
# Table name: projects
#
#  id                :integer          not null, primary key
#  name              :string
#  repo_url          :string
#  desc              :text
#  kind_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#  ruby_version      :string           default("2"), not null
#  database_adapter  :string           default("postgresql"), not null
#  database_name     :string           default("rails"), not null
#  database_username :string           default("rails"), not null
#  database_password :string           default("rails"), not null
#  secret            :string           default(""), not null
#  type              :string           default("RailsProject"), not null
#  port              :integer          default(80)
#  db_admin_password :string           default("")
#
