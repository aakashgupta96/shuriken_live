class UpdateFrame

  include Magick

  @queue = :update_frame

  def self.perform(post_id)
    post = Post.find(post_id)
    @graph = Koala::Facebook::API.new("241493676272963|I4nCO8TjSUEdG_g5myL7oGxSpGA")
    reactions = @graph.get_object("#{post.video_id}",fields: "reactions")
    txt = Draw.new
    txt.pointsize = 30
    txt.stroke = "orange"
    txt.fill = "black"
    txt.font_weight = Magick::BoldWeight
   
    if post.comparisons == 2
      obj1 = UpdateFrame.retrieve(post.compare_objects[0].emoticon,reactions)
      obj2 = UpdateFrame.retrieve(post.compare_objects[1].emoticon,reactions)
      frame = ImageList.new("public/uploads/post/#{post.id}/frame.png")
      frame.annotate(txt,0,0,200,335,obj1.to_s)
      frame.annotate(txt,0,0,500,335,obj2.to_s)
    elsif post.comparisons == 3
      obj1 =  UpdateFrame.retrieve(post.compare_objects[0].emoticon,reactions)
      obj2 =  UpdateFrame.retrieve(post.compare_objects[1].emoticon,reactions)
      obj3 =  UpdateFrame.retrieve(post.compare_objects[2].emoticon,reactions)
      frame = ImageList.new("public/uploads/post/#{post.id}/frame.png")
      frame.annotate(txt,0,0,130,340,obj1.to_s)
      frame.annotate(txt,0,0,350,340,obj2.to_s)
      frame.annotate(txt,0,0,580,340,obj3.to_s)
    elsif post.comparisons == 4
      obj1 =  UpdateFrame.retrieve(post.compare_objects[0].emoticon,reactions)
      obj2 =  UpdateFrame.retrieve(post.compare_objects[1].emoticon,reactions)
      obj3 =  UpdateFrame.retrieve(post.compare_objects[2].emoticon,reactions)
      obj4 =  UpdateFrame.retrieve(post.compare_objects[3].emoticon,reactions)
      frame = ImageList.new("public/uploads/post/#{post.id}/frame.png")
      frame.annotate(txt,0,0,160,215,obj1.to_s)
      frame.annotate(txt,0,0,480,215,obj2.to_s)
      frame.annotate(txt,0,0,160,425,obj3.to_s)
      frame.annotate(txt,0,0,480,425,obj4.to_s)
    elsif post.comparisons == 5
    elsif post.comparisons == 6
    end
    puts "Writing Frame"
    frame.write("public/uploads/post/#{post.id}/frame2.tmp.png")
    %x[mv "public/uploads/post/#{post.id}/frame2.tmp.png" "public/uploads/post/#{post.id}/frame2.png"]
    sleep(2)
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