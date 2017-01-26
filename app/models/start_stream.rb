class StartStream

	@queue = :start_stream

	def self.perform(post_id)
		post = Post.find(post_id)
		frame_path = "public/uploads/post/#{post.id}/frame2.png"
		if post.audio.url.nil?
			audio_path = "public/silent.aac"
		else
			audio_path = "public/uploads/post/#{post.id}"
			%x[$HOME/bin/ffmpeg -i "#{audio_path}/audio.aac" -codec:a aac -ac 1 -ar 44100 -b:a 128k "#{audio_path}/final.aac"]
			%x[$HOME/bin/ffmpeg -stream_loop 10000 -i "#{audio_path}/final.aac" -c copy -t 14400 "#{audio_path}/long.aac"]
			audio_path = "public/uploads/post/#{post.id}/long.aac"
		end
		result = %x[$HOME/bin/ffmpeg -loop 1 -re -y -f image2 -i #{frame_path} -i #{audio_path} -acodec copy -bsf:a aac_adtstoasc -pix_fmt yuv420p -profile:v high -s 1280x720 -vb 400k -maxrate 400k -minrate 400k -bufsize 600k -deinterlace -vcodec libx264 -preset veryfast -g 30 -r 30 -t 14400 -strict -2 -f flv "rtmp://rtmp-api.facebook.com:80/rtmp/#{post.key}" 2> #{Rails.root.join("log").join("stream").join(post.id.to_s).to_s} ]
		Resque.workers.each do |worker|
			if worker.working? and worker.queues.first == "update_frame" and worker.job["payload"]["args"].first==post_id
				victim = %x[pgrep -P #{worker.pid}]	
				victim.strip!
				victim = %x[pgrep -P #{victim}]	
				victim.strip!
				%x[kill -9 #{victim.to_i}]
			end
		end
		unless post.audio.url.nil?
			%x[rm #{audio_path}]
		end
	end
end
