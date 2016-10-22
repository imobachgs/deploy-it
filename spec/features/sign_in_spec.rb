require 'rails_helper'

RSpec.feature 'Signing in', type: :feature do
  background do
    visit root_path
  end

  scenario 'is required for a guest user' do
    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'is not allowed for an unconfirmed user' do
    user = create(:unconfirmed_user)
    sign_in(user)

    expect(current_path).to_not eq(root_path)
    expect(page).to have_content('You have to confirm your email address before continuing.')
  end

  scenario 'is allowed for a confirmed user' do
    user = create(:confirmed_user)
    sign_in(user)

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'successfully with GitHub account' do
    click_link 'Sign in with GitHub'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Successfully authenticated from GitHub account.')
  end
end
