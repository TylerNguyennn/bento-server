class Product < ApplicationRecord
  filterrific(
    default_filter_params: {},
    available_filters: [
      :search_query,
      :with_category,
      :with_price_gte,
      :with_price_lte
    ]
  )
  belongs_to :seller, class_name: "User"

  validates :title, :price, :category, presence: true

  # Tìm theo tên (query text)
  scope :search_query, ->(query) {
    return nil if query.blank?
    where("title ILIKE ?", "%#{query}%")
  }

  # Lọc theo category (giả sử category là string)
  scope :with_category, ->(category) {
    where(category: category)
  }

  # Lọc theo giá >= min
  scope :with_price_gte, ->(price) {
    where("price >= ?", price)
  }

  # Lọc theo giá <= max
  scope :with_price_lte, ->(price) {
    where("price <= ?", price)
  }
end
