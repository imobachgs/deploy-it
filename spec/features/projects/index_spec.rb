require 'rails_helper'

RSpec.feature 'Listing projects', type: :feature do
  given!(:project) { create(:project) }

  scenario 'List all projects' do
   visit '/projects'

   expect(page).to have_content(project.name)
  end
end
