def add_space(property='One bedroom flat in Holborn')
	visit '/myspaces/new'
	fill_in 'property', with: property
	click_button("Add space")
end
