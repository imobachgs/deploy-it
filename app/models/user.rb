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

  def has_machines?
    machines.present?
  end

  def private_key_as_text
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

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  ssh_public_key         :text
#  ssh_private_key        :text
#  provider               :string
#  uid                    :string
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
