class Post < ActiveRecord::Base
	mount_uploader :background, BackgroundUploader
	mount_uploader :audio, AudioUploader
	has_many :compare_objects
end
