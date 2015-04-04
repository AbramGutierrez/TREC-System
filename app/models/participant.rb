class Participant < ActiveRecord::Base
	belongs_to :team
	has_one :account, :as => :user
end
