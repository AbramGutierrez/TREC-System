class Administrator < ActiveRecord::Base
	has_one :account, :as => :user
end
