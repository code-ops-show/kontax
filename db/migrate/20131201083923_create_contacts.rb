class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :photo
      t.string :facebook
      t.string :twitter

      t.timestamps
    end
  end
end
