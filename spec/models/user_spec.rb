require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :ssh_public_key }
  it { is_expected.to validate_presence_of :ssh_private_key }

  it { is_expected.to have_many :projects }
  it { is_expected.to have_many :machines }

  describe '#has_machines?' do
    it 'returns true when user has machines' do
      user = create(:user)
      create(:machine, user: user)

      expect(user.has_machines?).to be_truly
    end

    it 'returns false when user has machines' do
      user = create(:user)

      expect(user.has_machines?).to be_falsey
    end
  end

  describe 'before validation' do
    it 'does not assign any key when email is blank' do
      user = build(:user, email: '')

      expect { user.valid? }.to_not change { user.ssh_public_key }
    end

    it 'assigns SSH public key on create' do
      user = build(:user)

      expect { user.valid? }.to change { user.ssh_public_key }
    end

    it 'assigns SSH private key on create' do
      user = build(:user)

      expect { user.valid? }.to change { user.ssh_private_key }
    end

    it 'does not assign SSH public key on update' do
      user = create(:user)

      expect { user.save }.to_not change { user.ssh_public_key }
    end

    it 'does not assign SSH private key on update' do
      user = create(:user)

      expect { user.save }.to_not change { user.ssh_private_key }
    end
  end

  describe '.from_omniauth(auth)' do
    let(:auth) { OmniAuth.config.mock_auth[:github] }

    it 'creates a new record when does not exist one previously' do
      expect { described_class.from_omniauth(auth) }.to change { User.count }.from(0).to 1
    end

    it 'does not create a new record when already exists' do
      create(:user, provider: auth.provider, uid: auth.uid)

      expect { described_class.from_omniauth(auth) }.to_not change { User.count }
    end
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
