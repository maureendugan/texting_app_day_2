class ChangeContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :user_id, :int
  end
end
