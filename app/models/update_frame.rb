class UpdateFrame

  require "koala"
  require "RMagick"
  include Magick

  @queue = :updateframe

  def self.perform(post)
    @graph = Koala::Facebook::API.new("241493676272963|I4nCO8TjSUEdG_g5myL7oGxSpGA")
    @reactions = @graph.get_object("#{postvideo_id}",fields: "reactions")
    
    txt = Draw.new
    txt.pointsize = 30
    txt.stroke = "orange"
    txt.fill = "black"
    txt.font_weight = Magick::BoldWeight
   
    if post.comparisons == 2
      obj1 = retrieve post.compare_objects[0].emoticon
      obj2 = retrieve post.compare_objects[1].emoticon
      frame = ImageList.new("public/uploads/post/#{post.id}/frame.jpg")
      frame.annotate(txt,0,0,200,355,obj1.to_s)
      frame.annotate(txt,0,0,500,355,obj2.to_s)
    elsif post.comparisons == 3
      obj1 =  retrieve post.compare_objects[0].emoticon
      obj2 =  retrieve post.compare_objects[1].emoticon
      obj3 =  retrieve post.compare_objects[2].emoticon
      frame = ImageList.new("public/uploads/post/#{post.id}/frame.jpg")
      frame.annotate(txt,0,0,130,340,obj1.to_s)
      frame.annotate(txt,0,0,350,340,obj2.to_s)
      frame.annotate(txt,0,0,580,340,obj3.to_s)
    elsif post.comparisons == 4
      obj1 =  retrieve post.compare_objects[0].emoticon
      obj2 =  retrieve post.compare_objects[1].emoticon
      obj3 =  retrieve post.compare_objects[2].emoticon
      obj4 =  retrieve post.compare_objects[3].emoticon
      frame = ImageList.new("public/uploads/post/#{post.id}/frame.jpg")
      frame.annotate(txt,0,0,160,215,obj1.to_s)
      frame.annotate(txt,0,0,480,215,obj2.to_s)
      frame.annotate(txt,0,0,160,425,obj3.to_s)
      frame.annotate(txt,0,0,480,425,obj4.to_s)
    elsif post.comparisons == 5
    elsif post.comparisons == 6
    end

    frame.write("public/uploads/post/#{post.id}/frame2.jpg")
  end

  def retrieve x
    count = 0;
    x = x.upcase
    @reactions["reactions"]["data"].each do |i|
      count = count + 1 if x == i["type"]
    end
    return count
  end

end