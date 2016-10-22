require 'rails_helper'

RSpec.feature 'Signing out', type: :feature do
  background do
    visit root_path

    user = create(:confirmed_user)
    sign_in(user)
  end

  scenario 'redirect to login form' do
    click_link 'Sign out'

    expect(current_path).to eq(new_user_session_path)
  end
end
