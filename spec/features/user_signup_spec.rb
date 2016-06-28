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

end


def signup
  visit('/signup');
  fill_in('email', with: 'diamond.oliver2@gmail.com')
  fill_in('password', with: 'waffles')
  click_button('Submit')
end
