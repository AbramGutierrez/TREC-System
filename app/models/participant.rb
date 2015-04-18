class Participant < ActiveRecord::Base
	belongs_to :team
	has_one :account, :as => :user
	validates :phone, presence: true
	validates :shirt_size, presence: true, inclusion: { in: %w(small medium large),
      message: "%{value} is not a valid size, try entering small, medium, or large." }
	# validates :captain, presence: true
end
