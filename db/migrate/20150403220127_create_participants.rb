class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
	  t.belongs_to :team, index: true
      t.boolean :captain
      t.boolean :waiver_signed
      t.string :shirt_size

      t.timestamps null: false
    end
  end
end
