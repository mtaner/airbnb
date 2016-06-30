def add_space(args = {})
  args[:name] ||= 'One bedroom flat in Holborn'
  args[:start_date] ||= '01/10/2016'
  args[:end_date] ||= '01/11/2016'
	signup
	visit '/myspaces/new'
  args.each { |k,v| fill_in(k.to_s, with: v) }
	click_button("Add space")
end

def signup(email: 'diamond.oliver2@gmail.com', password: 'waffles', password_confirmation: 'waffles')
  visit('/signup');
  fill_in('email', with: email)
  fill_in('password', with: password)
  fill_in('password_confirmation', with: password_confirmation)
  click_button('Submit')
end
