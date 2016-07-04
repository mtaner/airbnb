describe 'Feature - Requests' do

  feature 'Requesting a space' do

    before(:each) do
      add_space
      click_button('Sign out')
    end

    scenario 'I can request a space' do
      signup(email: 'theta@gmail.com')
      fill_in(:requested_date, with: '01/01/2017')
      click_button('Request space')
      expect(page).to have_content("Request has been sent for listing: 'One bedroom flat in Holborn'")
    end
  end

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
      click_link('request_4')
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
      click_link('request_5')
      click_button('Reject')
      expect(page).to have_content('space1 rejected')
    end
  end
end
