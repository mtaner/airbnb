require 'spec_helper'

feature 'viewing spaces' do
  scenario 'User can view the other spaces' do
    signup
    add_space
    visit '/myspaces'
    expect(page.status_code).to eq 200

    within 'ul#spaces' do
      expect(page).to have_content('Holborn')
    end
  end

end
