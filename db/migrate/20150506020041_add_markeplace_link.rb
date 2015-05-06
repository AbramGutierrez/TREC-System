class AddMarkeplaceLink < ActiveRecord::Migration
  def change
    add_column :conferences, :marketplace_link, :string
  end
end
