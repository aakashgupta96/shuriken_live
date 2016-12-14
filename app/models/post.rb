class Post < ActiveRecord::Base
	mount_uploader :background, BackgroundUploader

	has_many :compare_objects
end
