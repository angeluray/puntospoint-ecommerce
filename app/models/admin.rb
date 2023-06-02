class Admin < Account
    validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
    validates :role_level, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 2 }
end
