feature 'viewing availability' do
	before(:each) do
		add_space(name: 'space1')
		click_button('Sign out')
		signup(email: 'test@test.net')
		fill_in(:requested_date, with: '02/10/2016')
		click_button('Request space')
		click_button('Sign out')
		login
		visit('/requests')
		click_link('request_5')
		click_button('Approve')
	end

	scenario 'booked dates are shown on the page' do
		visit('/myspaces')
		expect(page).to have_content ('2016-10-02')
	end

end
