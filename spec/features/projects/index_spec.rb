require 'rails_helper'

RSpec.feature 'Listing projects', type: :feature do
  given(:user) { create(:confirmed_user) }
  given!(:project) { create(:project, user: user) }

  background do
    visit root_path
    sign_in(user)
    visit projects_path
  end

  scenario 'List all projects' do

   expect(page).to have_content(project.name)
  end
end
