require 'spec_helper'

feature "Users can send text messages", vcr: true do
  background do
    @user = FactoryGirl.create(:user)
    @contact = Contact.create(name: "Josh", phone_number: "5035046871", user: @user)
    @contact2 = Contact.create(name: "Moe", phone_number: "6072620716", user: @user)
  end

  scenario 'user sends a text message to two contacts' do
    sign_in(@user)
    visit user_path(@user)
    select @contact.name, from: :message_to
    select @contact2.name, from: :message_to
    fill_in :message_body, with: "This is a capybara test"
    click_button "Create Message"
    page.should have_content "Success"
  end
end

