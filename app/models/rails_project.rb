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
