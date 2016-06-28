def add_space
	visit '/myspaces/new'
	fill_in 'property', with: 'One bedroom flat in Holborn'
	click_button("Add space")
end
