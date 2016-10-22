class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

  before_validation :assign_ssh_keys, on: :create, unless: -> { email.blank? }

  validates :ssh_public_key, :ssh_private_key, presence: true

  private

  def ssh_key
    @ssh_key ||= SSHKey.generate(type: 'RSA', bits: 4096, passphrase: email)
  end

  def assign_ssh_keys
    self.ssh_public_key = ssh_key.public_key
    self.ssh_private_key = ssh_key.encrypted_private_key
  end
end
