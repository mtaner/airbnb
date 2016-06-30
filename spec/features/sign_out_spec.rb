feature 'User signs out' do

	scenario 'while being signed in' do
		signup
		click_button('Sign out')
		expect(page).to have_content('You have signed out')
	end


end
