require 'spec_helper'

feature 'Requesting a space' do

  before(:each) do
    add_space
    click_button('Sign out')
  end

  scenario 'I can request a space' do
    signup(email: 'theta@gmail.com')
    fill_in(:requested_date, with: '01/01/2017')
    click_button('Request space')
    expect(page).to have_content('Request has been sent')
    expect(page).to have_content('Holborn')
  end
end
