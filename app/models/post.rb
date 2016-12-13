class Post < ActiveRecord::Base
	mount_uploader :background_image, BackgroundImageUploader

	has_many :compare_objects
end
