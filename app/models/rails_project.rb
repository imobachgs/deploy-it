class RailsProject < Project
  validates :ruby_version, :adapter, :database,
    :username, :password, :secret, presence: true

  def self.roles
    RailsRole.all
  end
end
