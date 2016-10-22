require 'rails_helper'

feature 'Listing' do
  given!(:machine) { create(:machine) }

  scenario 'machines show title' do
    visit '/machines'

    expect(page).to have_content(machine.name)
  end

  scenario 'machine show ip' do
    visit '/machines'

    expect(page).to have_content(machine.ip)
  end

end

