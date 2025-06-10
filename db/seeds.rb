# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Giả sử đã có sẵn users (seller)
seller = User.find_by(role: 'seller') || User.first

Product.create!([
  {
    seller: seller,
    title: "Digital Marketing Basics",
    description: "An introductory ebook on digital marketing.",
    price: 19.99,
    category: "ebook",
    tags: ["marketing", "digital", "basics"],
    rating_avg: 4.5,
    published: true
  },
  {
    seller: seller,
    title: "Ruby on Rails Tutorial",
    description: "Comprehensive guide to Rails development.",
    price: 29.99,
    category: "ebook",
    tags: ["ruby", "rails", "programming"],
    rating_avg: 4.8,
    published: true
  },
  {
    seller: seller,
    title: "Photography Masterclass",
    description: "Advanced photography techniques and tips.",
    price: 39.99,
    category: "video",
    tags: ["photography", "masterclass", "video"],
    rating_avg: 4.2,
    published: true
  },
  {
    seller: seller,
    title: "Yoga for Beginners",
    description: "A beginner's video course on yoga.",
    price: 14.99,
    category: "video",
    tags: ["yoga", "health", "beginner"],
    rating_avg: 4.0,
    published: true
  }
])

puts "Seeded #{Product.count} products."
