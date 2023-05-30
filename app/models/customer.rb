class Customer < Account
  has_many :sales, foreign_key: 'account_id', dependent: :destroy, inverse_of: :customer

  # Add a counter cache for sales
  counter_cache :purchases_count
end
