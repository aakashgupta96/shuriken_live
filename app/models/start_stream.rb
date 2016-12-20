class StartStream

	@queue = :start_stream

	def self.perform(post_id)
		post = Post.find(post_id)
		#-t #{(post.duration-30.years).to_i}
		result = %x[ffmpeg -loop 1 -re -y -f image2 -i "public/uploads/post/#{post.id}/frame2.jpg" -i "public/silent.aac" -pix_fmt yuv420p -profile:v baseline -s 1280x720 -bufsize 6000k -vb 400k -maxrate 1500k -deinterlace -vcodec libx264 -preset veryfast  -g 30 -r 30 -strict -2 -f flv "rtmp://rtmp-api.facebook.com:80/rtmp/#{post.key}"]
	end
end