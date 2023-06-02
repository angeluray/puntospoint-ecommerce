class Category < ApplicationRecord
  belongs_to :account
  has_many :product_categorizations, dependent: :destroy
  has_many :products, through: :product_categorizations

  # Add counter cache for sales
  counter_cache :products_count
end
