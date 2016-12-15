class HardWorker
require 'koala'
	
  include Sidekiq::Worker
  
  def perform
    # now = Time.now + (5*60*60) + (30*60)
    # @set = Set.new
    # Post.all.each do|post|
    #   if ((((post.start_time.to_time + post.duration.to_i)-Time.new(2000).to_i) > now) and (post.start_time.to_time<=now) )
    #     @set.add(post)
    #   end
    # end

    # @set.all.each do |post|

    # end

  end

end
