require 'rails_helper'

RSpec.feature 'Manage machines', type: :feature do
  given(:user) { create(:confirmed_user) }
  context 'Create machine' do
    background do
      visit root_path
      sign_in(user)
      visit new_machine_path
    end

    scenario 'create and redirect to index on success' do
      fill_in 'Name', with: 'Great Machine'
      fill_in 'Ip', with: '192.165.345.13'

      click_button 'Create Machine'

      expect(page).to have_current_path(machines_path)
      expect(page).to have_content('Great Machine')
      expect(page).to have_content('192.165.345.13')
    end

    scenario 'redirect to form on error' do
      fill_in 'Name', with: 'Awesome'

      click_button 'Create Machine'

      expect(page).to have_selector('form#new_machine')
    end
  end

  context 'Update machine' do
    given(:user) { create(:confirmed_user) }
    given!(:machine) { create(:machine, user: user) }

    background do
      visit root_path
      sign_in(user)
      visit edit_machine_path(machine)
    end

    scenario 'update and redirect to index on success' do
      fill_in 'Ip', with: '10.32.123.23'

      click_button 'Update Machine'

      expect(page).to have_current_path(machines_path)
      expect(page).to have_content('10.32.123.23')
    end

    scenario 'redirect to form on error' do
      fill_in 'Ip', with: ''

      click_button 'Update Machine'

      expect(page).to have_selector('form.edit_machine')
    end
  end
end
