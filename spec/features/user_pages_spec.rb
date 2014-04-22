require 'spec_helper'

describe User, vcr: true do

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

  it 'should display an error if a message does not include number to send to' do
    user = FactoryGirl.create(:user)
    sign_in(user)
    contact = Contact.create({name: "Josh", phone_number: "5035046871", user_id: user.id})
    visit user_path(user)
    fill_in :message_body, with: "This is a capybara test"
    click_button "Create Message"
    page.should have_content "Please select a contact"
  end

  it 'should display a success message if all messages are sent correctly' do
    user = FactoryGirl.create(:user)
    sign_in(user)
    contact = Contact.create({name: "Josh", phone_number: "5035046871", user_id: user.id })
    contact2 = Contact.create({name: "Moe", phone_number: "6072620716", user_id: user.id })
    visit user_path(user)
    select contact.name, from: :message_to
    select contact2.name, from: :message_to
    fill_in :message_body, with: "This is a capybara test"
    click_button "Create Message"
    page.should have_content "Success"
  end

end
