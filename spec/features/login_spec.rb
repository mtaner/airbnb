feature 'User login' do
	let!(:user) do
		User.create( email: 'diamond.oliver@gmail.com',
								 password: 'waffle')
	end

	scenario 'with correct credentials' do
		visit('/login')
		fill_in(:email, with: 'diamond.oliver@gmail.com')
		fill_in(:password, with: 'waffle')
		click_button('Login')
		expect(current_path).to eq('/myspaces')
	end

  


end
