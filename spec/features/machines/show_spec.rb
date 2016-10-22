require 'rails_helper'

RSpec.feature 'Show', type: :feature do
  given(:user) { create(:confirmed_user) }
  given!(:machine) { create(:machine, user: user) }

  background do
    visit root_path
    sign_in(user)
    visit machine_path(machine)
  end

  scenario 'machine title' do
    expect(page).to have_content(machine.name)
  end

  scenario 'machine show ip' do
    expect(page).to have_content(machine.ip)
  end
end
