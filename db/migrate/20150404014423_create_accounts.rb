class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
	  t.references :user, polymorphic: true, index: true
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
  end
end
