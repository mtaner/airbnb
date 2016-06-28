feature 'User login' do
	let!(:user) do
		User.create( email: 'diamond.oliver@gmail.com',
								 password: 'waffle',
								 password_confirmation: 'waffle')
	end

	scenario 'with correct credentials' do
		visit('/sessions')
		fill_in(:email, with: 'diamond.oliver@gmail.com')
		fill_in(:password, with: 'waffle')
		click_button('Login')
		expect(current_path).to eq('/myspaces')
		expect(page).to have_content "Welcome, #{user.email}"
	end

end
