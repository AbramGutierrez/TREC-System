class AddDatesToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :conf_start_date, :date
    add_column :conferences, :conf_end_date, :date
  end
end
