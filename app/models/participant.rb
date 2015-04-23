class Participant < ActiveRecord::Base
	belongs_to :team
	has_one :account, :as => :user, dependent: :destroy
	
	validates :phone, :account, presence: true
	validates :shirt_size, presence: true, inclusion: { in: %w(small medium large),
      message: "%{value} is not a valid size, try entering small, medium, or large." }
	validates :captain, presence: true
	
	accepts_nested_attributes_for :account
end
