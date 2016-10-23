require 'rails_helper'

RSpec.describe RailsProject, type: :model do
  %i(ruby_version adapter database username password secret).each do |attr|
    it { is_expected.to validate_presence_of attr }
  end
end
