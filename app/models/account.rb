class Account < ApplicationRecord
    has_many :products, dependent: :destroy
    has_many :sales
    has_many :categories
end