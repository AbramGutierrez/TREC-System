class Administrator < ActiveRecord::Base
	has_one :account, :as => :user, dependent: :destroy
	
	validates :account, presence: true
	
	accepts_nested_attributes_for :account
end
