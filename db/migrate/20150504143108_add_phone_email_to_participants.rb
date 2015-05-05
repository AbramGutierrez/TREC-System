class AddPhoneEmailToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :phone_email, :string
  end
end
