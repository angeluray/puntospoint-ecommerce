class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :sales_count
      t.integer :product_stocks
      t.integer :sold_products
      t.decimal :product_earnings
      t.boolean :available
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
