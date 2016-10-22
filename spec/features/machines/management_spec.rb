require 'rails_helper'

RSpec.feature 'Manage machines', type: :feature do
  context 'Create machine' do
    background do
      visit "/machines/new"
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
    given!(:machine) { create(:machine) }

    background do
      visit "/machines/#{machine.id}/edit"
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
