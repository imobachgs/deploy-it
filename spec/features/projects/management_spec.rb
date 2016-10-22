require 'rails_helper'

RSpec.feature 'Manage projects', type: :feature do
  given(:user) { create(:confirmed_user) }
  given!(:rails_kind) { create(:project_kind, name: 'Rails') }
  given!(:html_kind) { create(:project_kind, name: 'HTML') }

  context 'Create' do
    background do
      visit root_path
      sign_in(user)
      visit new_project_path
    end

    scenario 'create and redirect to index on success' do
      fill_in 'Name', with: 'A Rails project'
      fill_in 'Repo url', with: 'Its repo url'
      select 'Rails', from: 'Kind'
      fill_in 'Desc', with: 'Its description'

      click_button 'Create Project'

      expect(page).to have_current_path(projects_path)
      expect(page).to have_content('A Rails project')
    end

    scenario 'redirect to form on error' do
      fill_in 'Desc', with: 'Lorem ipsum diary'

      click_button 'Create Project'

      expect(page).to have_content('can\'t be blank')
    end
  end

  context 'Update' do
    given!(:project) { create(:project, name: 'Wrong name', user: user) }

    background do
      visit root_path
      sign_in(user)
      visit projects_path

      within(:xpath, "//div[@id='project-#{project.id}']") do
        click_link 'Edit'
      end
    end

    scenario 'update and redirect to index on sucess' do
      expect(page).to have_current_path(edit_project_path(project))

      fill_in 'Name', with: 'Right name'

      click_button 'Update Project'

      expect(page).to have_current_path(projects_path)
      expect(page).to_not have_content('Wrong name')
      expect(page).to have_content('Right name')
    end

    scenario 'redirect to form on error' do
      fill_in 'Name', with: ''

      click_button 'Update Project'

      expect(page).to have_content('can\'t be blank')
    end
  end
end
