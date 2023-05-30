class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.integer :product_amount
      t.decimal :total_price
      t.datetime :purchased_at

      t.timestamps
    end
  end
end
