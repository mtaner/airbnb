require 'spec_helper'


feature 'Adding a space' do
  scenario 'I can fill in a form to add a space' do
    add_space
    expect(current_path).to eq '/myspaces'
  end

  scenario 'I can add a single space to my page' do
    add_space
    expect(page).to have_content('Holborn')
  end
end
