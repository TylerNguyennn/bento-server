class Tag < ApplicationRecord
  has_many :asset_tags
  has_many :products, through: :asset_tags
  belongs_to :parent_tag, class_name: 'Tag', optional: true
end