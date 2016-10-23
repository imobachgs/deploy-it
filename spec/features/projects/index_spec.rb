require 'rails_helper'

RSpec.feature 'Listing projects', type: :feature do
  given(:user) { create(:confirmed_user) }
  given!(:project) { create(:project, user: user) }

  background do
    visit root_path
    sign_in(user)
  end

  scenario 'List all projects' do
   visit projects_path

   expect(page).to have_content(project.name)
  end

  context 'User has machines' do
    background do
      create(:machine, user: user)
      visit projects_path
    end


    scenario 'does not show new project link' do
      expect(page).to have_link('Add new project')
    end
  end

  context 'User has not machines' do
    background do
      visit projects_path
    end


    scenario 'does not show new project link' do
      expect(page).to_not have_link('Add new project')
    end
  end
end
