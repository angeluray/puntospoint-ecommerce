class Customer < Account
  validates :address, presence: true, length: { maximum: 200 }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
end
