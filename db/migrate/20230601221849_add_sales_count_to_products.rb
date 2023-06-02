class AddSalesCountToProducts < ActiveRecord::Migration[7.0]
  def self.up
    add_column :products, :sales_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :products, :sales_count
  end
end
