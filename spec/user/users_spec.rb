
describe User do

  let!(:user) do
    User.create( email: 'diamond.oliver@gmail.com',
                 password: 'waffle',
                 password_confirmation: 'waffle')
  end

  it 'stores a user in the database' do
    expect(User.first.email).to eq("diamond.oliver@gmail.com")
  end

  it 'authenticates when a valid email and password is given' do
    authenticated_user = User.authenticate(user.email, user.password)
    expect(authenticated_user).to eq user
  end

  it 'does not autheticate with a wrong password or username' do
    expect(User.authenticate(user.email, '1234')).to eq nil
  end

end
