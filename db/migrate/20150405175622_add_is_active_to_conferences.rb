class AddIsActiveToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :is_active, :boolean
  end
end
