class Image < ActiveRecord::Base

  mount_uploader :image_url, ImageUploader
  
  validates :image_url, presence: true
  
end
