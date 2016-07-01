feature 'requests received' do
	scenario "user can view the requests recieved on their spaces" do
		add_space(name: 'space1')
		click_button('Sign out')
		signup(email: 'test@test.net')
		fill_in(:requested_date, with: '01/10/2016')
		click_button('Request space')
		click_button('Sign out')
		login
		visit('/requests')
		expect(page).to have_content('space1')
	end
end
