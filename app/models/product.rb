class Product < ApplicationRecord
  belongs_to :account
  has_many :images, as: :photolink
  has_many :product_categorizations, dependent: :destroy
  has_many :categories, through: :product_categorizations
  has_many :sales

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 3000 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :product_stocks, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :account_id, presence: true
end
