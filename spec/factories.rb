FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { "yayyayay"}
  end
end