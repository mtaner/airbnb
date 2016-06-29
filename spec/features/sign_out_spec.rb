feature 'User signs out' do

	scenario 'while being signed in' do
		signup
		click_button('Sign out')
		expect(page).to have_content('You have signed out')
	end


end

def signup(email: 'diamond.oliver2@gmail.com', password: 'waffles', password_confirmation: 'waffles')
  visit('/signup');
  fill_in('email', with: email)
  fill_in('password', with: password)
  fill_in('password_confirmation', with: password_confirmation)
  click_button('Submit')
end
