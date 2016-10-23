class RailsProject < Project
  before_validation :set_secure

  validates :ruby_version, :database_adapter, :database_name,
    :database_username, :database_password, :secret, presence: true, on: :update

  def self.roles
    RailsRole.all
  end

  def self.adapters
    RailsAdapter.all
  end


  private

  def set_secure
    self.secret = SecureRandom.hex(64)
    self.db_admin_password = SecureRandom.hex(10)
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
