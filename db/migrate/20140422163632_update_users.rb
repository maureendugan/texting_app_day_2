class UpdateUsers < ActiveRecord::Migration
  def change
    remove_column :users, :contact_id
    add_column :users, :phone_number, :string
  end
end
