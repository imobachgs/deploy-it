require 'rails_helper'

RSpec.describe Machine, type: :model do
  #TODO
  # it { should have_many :projects }

  it { should validate_presence_of :name  }
  it { should validate_presence_of :ip  }
end
