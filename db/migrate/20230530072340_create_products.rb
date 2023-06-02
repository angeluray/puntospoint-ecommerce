class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :product_stocks, default: 0
      t.integer :sold_products, default: 0
      t.decimal :product_earnings, default: 0
      t.boolean :available
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
