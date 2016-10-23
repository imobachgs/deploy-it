require 'rails_helper'

RSpec.feature 'Manage projects', type: :feature do
  given(:user) { create(:confirmed_user) }
  given!(:rails_kind) { create(:project_kind, name: 'Rails') }
  given!(:html_kind) { create(:project_kind, name: 'HTML') }

  context 'When user has machines' do
    background do
      visit root_path
      sign_in(user)
      create(:machine, user: user)
    end

    context 'Create' do
      background do
        visit new_project_path
      end

      scenario 'create and redirect to index on success' do
        fill_in 'Name', with: 'A Rails project'
        fill_in 'Repo url', with: 'Its repo url'
        select 'Rails', from: 'Kind'
        fill_in 'Desc', with: 'Its description'

        find('input[name=commit]').click

        expect(page).to have_selector("form.edit_rails_project")
      end

      scenario 'redirect to form on error' do
        fill_in 'Desc', with: 'Lorem ipsum diary'

        find('input[name=commit]').click

        expect(page).to have_content('can\'t be blank')
      end
    end

    context 'Update' do
      given!(:project) { create(:project, name: 'Wrong name', user: user) }

      background do
        visit projects_path

        within(:xpath, "//div[@id='project-#{project.id}']") do
          click_link 'Edit'
        end
      end

      scenario 'update and redirect to index on sucess' do
        expect(page).to have_current_path(edit_project_path(project))

        fill_in 'Name', with: 'Right name'

        find('input[name=commit]').click

        expect(page).to have_current_path(project_path(project))
        expect(page).to_not have_content('Wrong name')
        expect(page).to have_content('Right name')
      end

      scenario 'redirect to form on error' do
        fill_in 'Name', with: ''

        find('input[name=commit]').click

        expect(page).to have_content('can\'t be blank')
      end
    end
  end

  context 'When user has not machines' do
    background do
      visit root_path
      sign_in(user)
    end

    context 'Create' do
      background do
        visit new_project_path
      end

      scenario 'redirect to root_path with alert' do
        expect(page).to have_current_path(root_path)
        expect(page).to have_css('.is-error')
      end
    end
  end
end
