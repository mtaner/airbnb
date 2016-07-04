feature 'Sign Up' do
  scenario 'enters correct details and account is created' do
    signup
    expect(current_path).to eq('/myspaces')
  end

  scenario 'user cannot sign up with existing email address' do
    signup
    expect{signup}.to_not change(User, :count)
    expect(page).to have_content('Email is already taken')
  end

  scenario 'user cannot signup without correct password confirmation' do
    expect{ signup(password_confirmation: '123')}.not_to change(User, :count)
    expect(current_path).to eq('/signup')
    expect(page).to have_content('Password does not match the confirmation')
  end

  scenario 'user cannot signup with an invalid email address' do
    expect { signup(email: 'test@test')}.not_to change(User, :count)
    expect(current_path).to eq('/signup')
    expect(page).to have_content('Email has an invalid form')
  end

  scenario 'user cannot signup without an email address' do
    expect { signup(email: nil)}.not_to change(User, :count)
    expect(current_path).to eq('/signup')
    expect(page).to have_content('Email must not be blank')
  end

  scenario 'user can sign out while being signed in' do
    signup
    click_button('Sign out')
    expect(page).to have_content('You have signed out')
  end
end

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
