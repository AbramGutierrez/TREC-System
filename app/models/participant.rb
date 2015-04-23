class Participant < ActiveRecord::Base
	belongs_to :team
	has_one :account, :as => :user, dependent: :destroy
	
	validates :phone, :account, presence: true
	validates :shirt_size, presence: true, inclusion: { in: %w(small medium large),
      message: "%{value} is not a valid size, try entering small, medium, or large." }
	  
	# Apparently Ruby views nil and false as the same thing, so this only allows captain to be true
	# validates :captain, presence: true
	
	# We could do something like this, but it is not necessary
	validates :captain, inclusion: [true, false]
	
	accepts_nested_attributes_for :account
end
