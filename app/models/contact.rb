class Contact < ActiveRecord::Base

	validates :rank, :group, :position, :name, :email, :presence => true
	validates :rank, :numericality => { :greater_than_or_equal_to => 1}

end
