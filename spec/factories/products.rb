FactoryBot.define do
  factory :product do
    association :seller, factory: :user
    title { "Sample Product" }
    description { "This is a sample product." }
    price { 9.99 }
    category { "Electronics" }
    tags { "sample,product" }
    rating_avg { 4.5 }
    published { true }
  end
end
