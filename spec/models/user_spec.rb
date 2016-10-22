require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :ssh_public_key }
  it { is_expected.to validate_presence_of :ssh_private_key }

  it { is_expected.to have_many :projects }
  it { is_expected.to have_many :machines }

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
