class AssetTag < ApplicationRecord
  belongs_to :product, foreign_key: :asset_id
  belongs_to :tag
end
