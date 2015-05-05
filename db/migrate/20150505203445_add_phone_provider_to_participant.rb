class AddPhoneProviderToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :phone_provider, :string
  end
end
