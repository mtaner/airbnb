feature 'requests approved' do
	scenario "user can approve the requests recieved on their spaces" do
		add_space(name: 'space1')
		click_button('Sign out')
		signup(email: 'test@test.net')
		fill_in(:requested_date, with: '01/10/2016')
		click_button('Request space')
		click_button('Sign out')
		login
		visit('/requests')
		click_link('request_1')
		click_button('Approve')
		expect(page).to have_content('space1 approved')
	end
end

feature 'requests rejected' do
	scenario "user can reject the requests recieved on their spaces" do
		add_space(name: 'space1')
		click_button('Sign out')
		signup(email: 'test@test.net')
		fill_in(:requested_date, with: '01/10/2016')
		click_button('Request space')
		click_button('Sign out')
		login
		visit('/requests')
		click_link('request_2')
		click_button('Reject')
		expect(page).to have_content('space1 rejected')
	end
end