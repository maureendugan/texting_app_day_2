require 'spec_helper'

describe User do

  it 'should sign a user up for an account' do
    user = FactoryGirl.build(:user)
    visit new_user_registration_path
    fill_in :user_phone_number, with: user.phone_number
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    fill_in :user_password_confirmation, with: user.password_confirmation
    click_button "Sign up"
    page.should have_content "Logged in as #{user.email}"
  end

end
