class ChangePhoneTypeInParticipants < ActiveRecord::Migration
  def self.up
    change_column :participants, :phone, :string
  end
  
  def self.down
    change_column :participants, :phone, :integer
  end
end
