class UpdateFrame

  include Magick

  @queue = :update_frame

  def self.perform(post_id)
    post = Post.find(post_id)
    @graph = Koala::Facebook::API.new(ENV["FB_ACCESS_TOKEN"])
    #error = 0
    #count = count + 525
    loop do 
      
    begin
      reactions = @graph.get_object("#{post.video_id}",fields: "reactions")
      txt = Draw.new
      txt.pointsize = 30
      txt.stroke = "black"
      txt.fill = "white"
      txt.font_weight = Magick::BoldWeight
     
      if post.comparisons == 2
        obj1 = UpdateFrame.retrieve(post.compare_objects[0].emoticon,reactions)
        obj2 = UpdateFrame.retrieve(post.compare_objects[1].emoticon,reactions)
        frame = ImageList.new("public/uploads/post/#{post.id}/frame.png")
        frame.annotate(txt,0,0,200,325,obj1.to_s)
        frame.annotate(txt,0,0,500,325,obj2.to_s)
      elsif post.comparisons == 3
        obj1 =  UpdateFrame.retrieve(post.compare_objects[0].emoticon,reactions)
        obj2 =  UpdateFrame.retrieve(post.compare_objects[1].emoticon,reactions)
        obj3 =  UpdateFrame.retrieve(post.compare_objects[2].emoticon,reactions)
        frame = ImageList.new("public/uploads/post/#{post.id}/frame.png")
        frame.annotate(txt,0,0,130,320,obj1.to_s)
        frame.annotate(txt,0,0,350,320,obj2.to_s)
        frame.annotate(txt,0,0,580,320,obj3.to_s)
      elsif post.comparisons == 4
        obj1 =  UpdateFrame.retrieve(post.compare_objects[0].emoticon,reactions)
        obj2 =  UpdateFrame.retrieve(post.compare_objects[1].emoticon,reactions)
        obj3 =  UpdateFrame.retrieve(post.compare_objects[2].emoticon,reactions)
        obj4 =  UpdateFrame.retrieve(post.compare_objects[3].emoticon,reactions)
        frame = ImageList.new("public/uploads/post/#{post.id}/frame.png")
        frame.annotate(txt,0,0,160,200,obj1.to_s)
        frame.annotate(txt,0,0,480,200,obj2.to_s)
        frame.annotate(txt,0,0,160,380,obj3.to_s)
        frame.annotate(txt,0,0,480,380,obj4.to_s)
      elsif post.comparisons == 5
        obj1 =  UpdateFrame.retrieve(post.compare_objects[0].emoticon,reactions)
        obj2 =  UpdateFrame.retrieve(post.compare_objects[1].emoticon,reactions)
        obj3 =  UpdateFrame.retrieve(post.compare_objects[2].emoticon,reactions)
        obj4 =  UpdateFrame.retrieve(post.compare_objects[3].emoticon,reactions)
        obj5 =  UpdateFrame.retrieve(post.compare_objects[4].emoticon,reactions)
        frame = ImageList.new("public/uploads/post/#{post.id}/frame.png")
        frame.annotate(txt,0,0,130,200,obj1.to_s)
        frame.annotate(txt,0,0,360,200,obj2.to_s)
        frame.annotate(txt,0,0,580,200,obj3.to_s)
        frame.annotate(txt,0,0,220,380,obj4.to_s)
        frame.annotate(txt,0,0,460,380,obj5.to_s)
      elsif post.comparisons == 6
        obj1 =  UpdateFrame.retrieve(post.compare_objects[0].emoticon,reactions)
        obj2 =  UpdateFrame.retrieve(post.compare_objects[1].emoticon,reactions)
        obj3 =  UpdateFrame.retrieve(post.compare_objects[2].emoticon,reactions)
        obj4 =  UpdateFrame.retrieve(post.compare_objects[3].emoticon,reactions)
        obj5 =  UpdateFrame.retrieve(post.compare_objects[4].emoticon,reactions)
        obj6 =  UpdateFrame.retrieve(post.compare_objects[5].emoticon,reactions)
        frame = ImageList.new("public/uploads/post/#{post.id}/frame.png")
        frame.annotate(txt,0,0,130,200,obj1.to_s)
        frame.annotate(txt,0,0,360,200,obj2.to_s)
        frame.annotate(txt,0,0,580,200,obj3.to_s)
        frame.annotate(txt,0,0,130,380,obj4.to_s)
        frame.annotate(txt,0,0,360,380,obj5.to_s)
        frame.annotate(txt,0,0,580,380,obj6.to_s)
      end

      #puts "Writing Frame"
      
      frame.write("public/uploads/post/#{post.id}/frame2.tmp.png")
      %x[mv "public/uploads/post/#{post.id}/frame2.tmp.png" "public/uploads/post/#{post.id}/frame2.png"]
      #sleep(0.8)
      rescue
        #error = error + 1
        #if(error<count)
          #sleep(1)
         # puts "Error occured "
          retry
        #else
         # return
        #end
     end
  end
end

  def self.retrieve x,reactions
    count = 0;
    x = x.upcase
    if(reactions.nil? or reactions["reactions"].nil? or reactions["reactions"]["data"].nil?)
      return 0
    end
    reactions["reactions"]["data"].each do |i|
      count = count + 1 if x == i["type"]
    end
    return count
  end

end
