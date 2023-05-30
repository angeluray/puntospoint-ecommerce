class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :password_confirmation
      t.string :auth_token
      t.string :type

      t.timestamps
    end
  end
end
