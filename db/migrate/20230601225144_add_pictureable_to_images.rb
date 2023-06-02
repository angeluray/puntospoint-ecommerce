class AddPictureableToImages < ActiveRecord::Migration[7.0]
  def change
    add_column :images, :photolink_type, :string
    add_column :images, :photolink_id, :integer
  end
end
