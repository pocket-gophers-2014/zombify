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

  factory :session do
    id { rand(5) }
  end
end