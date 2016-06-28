def add_space( name = 'One bedroom flat in Holborn' )
	visit '/myspaces/new'
	fill_in 'name', with: name
	click_button("Add space")
end
