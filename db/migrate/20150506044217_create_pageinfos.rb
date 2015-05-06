class CreatePageinfos < ActiveRecord::Migration
  def change
    create_table :pageinfos do |t|
      t.string :page
      t.text :body

      t.timestamps null: false
    end
  end
end
