class ProductCategorization < ApplicationRecord
  belongs_to :product, touch: true
  belongs_to :category, touch: true

  validates :product_id, presence: true
  validates :category_id, presence: true
end
