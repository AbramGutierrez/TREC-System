class Participant < ActiveRecord::Base
	belongs_to :team
	has_one :account, :as => :user, dependent: :destroy
	validates :shirt_size, :phone, :account, presence: true
	# validates :captain, presence: true
	
	accepts_nested_attributes_for :account
end
