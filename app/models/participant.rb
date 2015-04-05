class Participant < ActiveRecord::Base
	belongs_to :team
	has_one :account, :as => :user
	validates :captain, :shirt_size, :phone, presence: true
end
