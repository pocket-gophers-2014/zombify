FactoryGirl.define do
  factory :user do
    email { Faker::Name.name }
    password_digest { Faker::Name.name }
  end
end