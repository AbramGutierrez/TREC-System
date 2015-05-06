class Pageinfo < ActiveRecord::Base

	validates :page, :body, presence: true

end
