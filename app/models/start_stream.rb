class StartStream

	@queue = :start_stream

	def self.perform(post_id)
		post = Post.find(post_id)
		result = %x[$HOME/bin/ffmpeg -loop 1 -re -y -f image2 -i "public/uploads/post/#{post.id}/frame2.png" -i "public/silent.aac" -codec:a aac -ac 1 -ar 44100 -b:a 128k -pix_fmt yuv420p -profile:v high -s 1280x720 -vb 400k -maxrate 400k -minrate 400k -bufsize 600k -deinterlace -vcodec libx264 -preset veryfast -t #{(post.duration-30.years).to_i + 50} -g 30 -r 30 -strict -2 -f flv "rtmp://rtmp-api.facebook.com:80/rtmp/#{post.key}" 2> #{Rails.root.join("log").join("stream").join(post.id.to_s).to_s} ]

		Resque.workers.each do |worker|
			if worker.working? and worker.queues.first == "update_frame" and worker.job["payload"]["args"].first==post_id
				victim = %x[pgrep -P #{worker.pid}]
				victim.strip!
				%x[kill -9 #{victim.to_i}]
			end
		end
	end
end
