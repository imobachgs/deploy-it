class RailsProject < Project
  validates :ruby_version, :adapter, :database,
    :username, :password, :secret, presence: true
end
