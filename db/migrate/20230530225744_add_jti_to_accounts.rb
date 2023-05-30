class AddJtiToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :jti, :string, null: false
    add_index :accounts, :jti, unique: true
  end
end
