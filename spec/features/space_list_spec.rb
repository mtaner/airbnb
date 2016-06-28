require 'spec_helper'


feature 'Adding a space' do
  scenario 'I can fill in a form to add and name a space' do
    add_space
    expect(current_path).to eq '/myspaces'
  end

  scenario 'I can add a single space to my page' do
    add_space
    expect(page).to have_content('Holborn')
  end

  scenario 'I can add multiple spaces to my page' do
    add_space
    add_space('Kensington')
    expect(page).to have_content('Holborn')
    expect(page).to have_content('Kensington')
  end


  scenario 'I can add a description to my space, when i post it' do
    description = 'sample space description'
    visit '/myspaces/new'
    fill_in 'name', with: 'sample space name'
    fill_in 'description', with: description 
    click_button("Add space")
    expect(page).to have_content(description)
  end

  scenario 'I can add a price per night to my space when i post it' do
    price = 60.5
    visit '/myspaces/new'
    fill_in 'name', with: 'sample space name'
    fill_in 'price', with: price 
    click_button("Add space")
    expect(page).to have_content(price)
  end

end
