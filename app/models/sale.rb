class Sale < ApplicationRecord
  belongs_to :account
  belongs_to :product
  counter_culture :product
  belongs_to :category
  counter_culture :category
  
  before_save :decrease_product_stocks
  before_save :add_total_amount
  before_save :set_admin
  before_save :increase_earnings
  after_create :increase_sold_products
  after_create :send_first_sale_notification

  validates :product_amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :total_price, presence: true, numericality: { greater_than: 0 }
  validates :account_id, presence: true
  validates :admin_id, presence: true
  validates :category_id, presence: true
  validates :product_id, presence: true
  validates :purchased_at, presence: true

  before_validation :set_purchased_at, on: :create
  before_validation :add_total_amount, on: :create
  before_validation :set_admin, on: :create

  def set_purchased_at
    self.purchased_at ||= Time.current
  end

  def send_first_sale_notification
    if product.sales_count == 1
      creator = product.account
      admins = Account.where(type: 'admin').where.not(id: creator.id)

      ProductMailer.product_first_sale_notification(creator, admins, product, self).deliver_now
    end
  end

  def add_total_amount
    product = Product.find(self.product_id)
    self.total_price ||= BigDecimal((self.product_amount * product.price).to_s)
  end

  private

  def set_admin
    if self.admin_id.nil? || self.admin_id?
      product = Product.find(self.product_id)
      admin = Account.find(product.account_id)
      self.admin_id = admin.id
    end
  end

  def decrease_product_stocks
    product = Product.find(self.product_id)
    product.product_stocks -= self.product_amount
    product.product_stocks = 0 if product.product_stocks < 0
    if product.product_stocks == 0
      product.available = false
    end
    product.save
  end

  def increase_sold_products
    product = Product.find(self.product_id)
    product.sold_products += self.product_amount
    product.save
  end

  def increase_earnings
    product = Product.find(self.product_id)
    product.product_earnings += self.total_price
    product.save
  end
end
