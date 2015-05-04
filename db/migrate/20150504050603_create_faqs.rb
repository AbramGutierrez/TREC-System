class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.integer :order
      t.text :question
      t.text :answer

      t.timestamps null: false
    end
  end
end
