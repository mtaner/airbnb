feature 'Adding a space' do
  scenario 'I can fill in a form to add and name a space' do
    signup
    add_space
    expect(current_path).to eq '/myspaces'
  end

  scenario 'I can add a single space to my page' do
    signup
    add_space
    expect(page).to have_content('Holborn')
  end

  scenario 'I can add multiple spaces to my page' do
    signup
    add_space
    add_space(name: 'Kensington')
    expect(page).to have_content('Holborn')
    expect(page).to have_content('Kensington')
  end


  scenario 'I can add a description to my space, when i post it' do
    description = 'sample space description'
    signup
    add_space(description: description)
    expect(page).to have_content(description)
  end

  scenario 'I can add a price per night to my space when i post it' do
    price = 60.5
    signup
    add_space(price: price)
    expect(page).to have_content(price)
  end

  scenario 'I can add an availability date range to my space when i post it' do
    signup
    add_space(start_date: '2016-10-01', end_date: '2016-11-01')
    expect(page).to have_content('From: 2016-10-01')
    expect(page).to have_content('To: 2016-11-01')
  end

  scenario 'I cannot enter a space if I have not entered a correct date range' do
    signup
    add_space(start_date: '')
    expect(page).to have_content('Start date must be of type Date')
  end

end
