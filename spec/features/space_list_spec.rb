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

  scenario 'I can add an availability date range to my space when i post it' do
    visit '/myspaces/new'
    fill_in 'name', with: 'sample space name'
    fill_in 'start_date', with: '2016-10-01'
    fill_in 'end_date', with: '2016-11-01'
    click_button("Add space")
    expect(page).to have_content('From: 2016-10-01')
    expect(page).to have_content('To: 2016-11-01')
  end

  scenario 'I cannot enter a space if I have not entered a correct date range' do
    visit '/myspaces/new'
    fill_in 'name', with: 'sample space name'
    fill_in 'start_date', with: ''
    click_button('Add space')
    expect(page).to have_content('Please enter a valid date')
  end

end
