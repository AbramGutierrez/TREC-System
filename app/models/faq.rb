class Faq < ActiveRecord::Base
	
	validates :order, :question, :answer, :presence => true
	validates :order, :numericality => { :greater_than_or_equal_to => 1}

end
