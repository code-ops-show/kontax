class AddIndexForContacts < ActiveRecord::Migration
  def change
    add_index :contacts, [:name, :email]
  end
end
