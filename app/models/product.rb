class Product < ApplicationRecord
  belongs_to :account
  has_many :product_categorizations, dependent: :destroy
  has_many :categories, through: :product_categorizations
  has_many :sales

  # Add counter cache for sales
  counter_cache :sales_count
end
