
feature 'viewing spaces' do
  scenario 'User can view the other spaces' do
    Space.create(name: 'One bedroom flat in Holborn')
    visit '/myspaces'
    expect(page.status_code).to eq 200

    within 'ul#spaces' do
      expect(page).to have_content('Holborn')
    end
  end

end
