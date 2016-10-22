require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :ssh_public_key }
  it { is_expected.to validate_presence_of :ssh_private_key }

  it { should have_many :projects }
  it { should have_many :machines }

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
end
