require 'spec_helper'


feature 'Adding a space' do
  scenario 'I can add a single space to my page' do
    visit '/myspaces/new'
    fill_in 'space', with: 'One bedroom flat in Holborn'
    click_button("Add space")
    expect(current_path).to eq '/myspaces'
  end
end
