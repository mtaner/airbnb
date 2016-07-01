feature 'Viewing requests' do
	before(:each) do
		add_space
		click_button('Sign out')
	end

	scenario 'I can view the requests that I have made' do
		signup(email: 't@t.com')
		fill_in(:requested_date, with: '01/01/2017')
		click_button('Request space')
		visit('/requests')
		expect(page).to have_content('Holborn')
		expect(page).to have_content('2017-01-01')

	end
end