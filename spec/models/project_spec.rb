require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should belong_to(:kind).class_name('ProjectKind') }
  it { should belong_to :user }
  it { should have_many(:assignments) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:repo_url) }
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
