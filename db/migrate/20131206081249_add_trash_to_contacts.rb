class AddTrashToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :trash, :boolean, default: false
  end
end
