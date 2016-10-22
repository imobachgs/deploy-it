require 'rails_helper'

feature 'Show' do
  given!(:machine) { create(:machine) }

  scenario 'machine title' do
    visit "/machines/#{machine.id}"

    expect(page).to have_content(machine.name)
  end

  scenario 'machine show ip' do
    visit "/machines/#{machine.id}"

    expect(page).to have_content(machine.ip)
  end

end

