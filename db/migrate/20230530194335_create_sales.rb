class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.integer :product_amount
      t.decimal :total_price, null: false, default: 0
      t.datetime :purchased_at
      t.integer :admin_id
      t.references :product, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
