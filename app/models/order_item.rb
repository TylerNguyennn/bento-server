class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, foreign_key: :asset_id
end
