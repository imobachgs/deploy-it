require 'rails_helper'

RSpec.feature 'Profile', type: :feature do
  scenario 'displays SSH public key' do
    visit root_path

    user = create(:confirmed_user)
    sign_in(user)

    click_link 'Profile'

    expect(page).to have_content(user.email)
    expect(page).to have_content(user.ssh_public_key)
    expect(page).to_not have_content(user.ssh_private_key)
  end
end
