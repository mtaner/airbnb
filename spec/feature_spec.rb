require 'spec_helper'


feature 'Sign Up' do
  it 'enters correct details and account is created' do
    visit('/signup');
    within('#signup') do
      fill_in('#email', with: 'diamond.oliver@gmail.com')
      fill_in('#password', with: 'waffles')
      click_button('#submit')
    end
    expect(page).to have_content('Success!')
  end

end
