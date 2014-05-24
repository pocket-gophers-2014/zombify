FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { "yayyayay"}
  end

  factory :post do
    body { Faker::Internet.email}
    title { Faker::Internet.email}
    audience { "human" }
  end
end