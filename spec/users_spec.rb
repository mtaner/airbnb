require 'data_mapper'

describe User do 
  
  let!(:user) do
    User.create( email: 'diamond.oliver@gmail.com',
                 password: 'waffle')
  end
  
  it 'stores a user in the database' do
    expect(User.first.email).to eq("diamond.oliver@gmail.com") 
  end

end
