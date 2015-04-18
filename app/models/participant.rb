class Participant < ActiveRecord::Base
	belongs_to :team
	has_one :account, :as => :user
	validates :shirt_size, :phone, presence: true
	validates :captain, presence: true
end
