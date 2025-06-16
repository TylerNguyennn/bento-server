FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    email { Faker::Internet.email }
    password { "password123" }
    after(:create) do |user|
      user.roles << Role.find_or_create_by(name: 'buyer')
    end
  end
end
