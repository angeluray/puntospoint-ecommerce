class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :address
      t.decimal :balance
      t.integer :purchases_count

      t.timestamps
    end
  end
end
