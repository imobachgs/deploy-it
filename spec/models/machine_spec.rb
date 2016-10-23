require 'rails_helper'

RSpec.describe Machine, type: :model do
  it { should belong_to :user }

  it { should validate_presence_of :user_id  }
  it { should validate_presence_of :name  }
  it { should validate_presence_of :ip  }

  describe '#assigned?' do
    xit 'returns true when machine has assignments' do
    end

    xit 'returns false when machine has not assignments' do
    end
  end
end
