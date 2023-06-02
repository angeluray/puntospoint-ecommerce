class Category < ApplicationRecord
    belongs_to :account
    has_many :product_categorizations, dependent: :destroy
    has_many :products, through: :product_categorizations
    has_many :sales, dependent: :destroy

    validates :name, presence: true, length: { maximum: 100 }
    validates :account_id, presence: true
end
