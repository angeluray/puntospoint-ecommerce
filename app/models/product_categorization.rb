class ProductCategorization < ApplicationRecord
  belongs_to :product, touch: true
  belongs_to :category, touch: true
end
