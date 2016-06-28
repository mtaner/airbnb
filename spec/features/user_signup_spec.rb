require 'spec_helper'


feature 'Sign Up' do
  scenario 'enters correct details and account is created' do
    signup
    expect(current_path).to eq('/myspaces')
  end

  scenario 'user cannot sign up with existing email address' do
    signup
    expect{signup}.to_not change(User, :count)
  end

  scenario 'user cannot signup without correct password confirmation' do
    expect{ signup(password_confirmation: '123')}.not_to change(User, :count)
    expect(current_path).to eq('/signup')
  end

  scenario 'user cannot signup with an invalid email address' do
    expect { signup(email: 'test@test')}.not_to change(User, :count)
    expect(current_path).to eq('/signup')
  end

  scenario 'user cannot signup without an email address' do
    expect { signup(email: nil)}.not_to change(User, :count)
    expect(current_path).to eq('/signup')
  end
end


def signup(email: 'diamond.oliver2@gmail.com', password: 'waffles', password_confirmation: 'waffles')
  visit('/signup');
  fill_in('email', with: email)
  fill_in('password', with: password)
  fill_in('password_confirmation', with: password_confirmation)
  click_button('Submit')
end
