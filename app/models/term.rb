class Term < ActiveRecord::Base

	validates :order, :body, :presence => true
	validates :order, :numericality => { :greater_than_or_equal_to => 1}

end
