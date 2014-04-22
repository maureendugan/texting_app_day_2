FactoryGirl.define do

  sequence :email do |n|
    email = Faker::Internet.email
  end


  factory :user do
    email
    password Faker::Internet.password
    password_confirmation { |u| u.password }
  end
end
