class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.time :start_time
      t.time :end_time
      t.text :event_desc

      t.timestamps null: false
    end
  end
end
