class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :rank
      t.string :group
      t.string :position
      t.string :name
      t.string :email
      t.string :other

      t.timestamps null: false
    end
  end
end
