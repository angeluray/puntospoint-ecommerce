class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :password
      t.string :password_confirmation
      t.string :auth_token
      t.string :address
      t.decimal :balance, default: 0
      t.integer :purchases_count
      t.string :type
      t.integer :role_level

      t.timestamps
    end
  end
end
