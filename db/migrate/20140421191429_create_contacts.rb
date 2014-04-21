class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :phone_number
    end

    add_column :users, :contact_id, :integer
  end
end
