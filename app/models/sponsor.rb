class Sponsor < ActiveRecord::Base
	belongs_to :conference
	mount_uploader :logo_path, ImageUploader
	validates :conference, :logo_path, :sponsor_name, :priority, presence: true
	validates :priority, :inclusion => 1..4
end
