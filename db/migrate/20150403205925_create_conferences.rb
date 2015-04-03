class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.date :start_date
      t.date :end_date
      t.integer :max_team_size
      t.integer :min_team_size
      t.integer :max_teams
      t.float :tamu_cost
      t.float :other_cost
      t.text :challenge_desc

      t.timestamps null: false
    end
  end
end
