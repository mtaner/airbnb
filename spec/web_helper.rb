def add_space(args = {})
  args[:name] ||= 'One bedroom flat in Holborn'
	signup
	visit '/myspaces/new'
	fill_in 'name', with: args[:name]
  fill_in 'start_date', with: '01/01/2011'
	click_button("Add space")
end

def signup(email: 'diamond.oliver2@gmail.com', password: 'waffles', password_confirmation: 'waffles')
  visit('/signup');
  fill_in('email', with: email)
  fill_in('password', with: password)
  fill_in('password_confirmation', with: password_confirmation)
  click_button('Submit')
end
