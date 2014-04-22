FactoryGirl.define do

  sequence :email do |n|
    email = Faker::Internet.email
  end


  factory :user do
    email
    phone_number '9718017923'
    password Faker::Internet.password
    password_confirmation { |u| u.password }
  end
end
