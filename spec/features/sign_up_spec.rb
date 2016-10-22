require 'rails_helper'

RSpec.feature 'Signing up', type: :feature do
  scenario 'requires account confirmation' do
    visit root_path
    click_link 'Sign up'

    expect(current_path).to eq(new_user_registration_path)

    sign_up(attributes_for(:user))

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
