require 'rails_helper'

feature 'Listing projects' do
  given!(:project) { create(:project) }

  scenario 'List all projects' do
   visit '/projects'

   expect(page).to have_content(project.name)
  end
end
