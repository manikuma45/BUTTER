class Support < ApplicationRecord
	validates :title, presence: true
	validates :content, presence: true
	validates :price, presence: true
	validates :price, presence: true
	mount_uploader :image, ImageUploader

end
