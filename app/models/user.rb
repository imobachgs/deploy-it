class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable,
     :omniauthable, omniauth_providers: [:github]

  has_many :projects
  has_many :machines

  before_validation :assign_ssh_keys, on: :create, unless: -> { email.blank? }

  validates :ssh_public_key, :ssh_private_key, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider     = auth.provider
      user.uid          = auth.uid
      user.email        = auth.info.email
      user.password     = Devise.friendly_token[0,20]
      user.confirmed_at = Time.current
    end
  end

  def private_key
    #OpenSSL::PKey::RSA.new(ssh_private_key, user.email).to_pem
    SSHKey.new(ssh_private_key, passphrase: email).private_key
  end

  def public_key_as_text
    SSHKey.new(ssh_public_key, comment: email).ssh_public_key
  end

  private

  def ssh_key
    @ssh_key ||= SSHKey.generate(type: 'RSA', bits: 4096, passphrase: email)
  end

  def assign_ssh_keys
    self.ssh_public_key = ssh_key.public_key
    self.ssh_private_key = ssh_key.encrypted_private_key
  end
end
