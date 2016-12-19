class EditorController < ApplicationController
	
	require "RMagick"
	include Magick

  def testFrame
    post = Post.last
    
    txt = Draw.new
    txt.pointsize = 30
    txt.stroke = "orange"
    txt.fill = "black"
    txt.font_weight = Magick::BoldWeight
   
    obj1 =  8#retrieve post.compare_objects[0].emoticon
    obj2 =  3#retrieve post.compare_objects[1].emoticon
    obj3 =  4#retrieve post.compare_objects[2].emoticon
    obj4 =  4#retrieve post.compare_objects[3].emoticon
    frame = ImageList.new("public/uploads/post/#{post.id}/frame.jpg")
    frame.annotate(txt,0,0,160,215,obj1.to_s)
    frame.annotate(txt,0,0,480,215,obj2.to_s)
    frame.annotate(txt,0,0,160,425,obj3.to_s)
    frame.annotate(txt,0,0,480,425,obj4.to_s)
    
    frame.write("public/uploads/post/#{post.id}/frame2.jpg")
    send_data frame.to_blob, :stream => "false", :filename => "test.jpg", :type => "image/jpeg", :disposition => "inline"
  end

	def createFrame 
    post = Post.last
    background = ImageList.new("public/uploads/post/#{post.id}/background/large_1.jpg")
    result = background
    
    # Adding title to background
    title = Draw.new
    title.gravity = Magick::NorthGravity
    title.pointsize = 40
    title.stroke = "black"
    title.fill = "#ffffff"
    title.font_weight = Magick::BoldWeight

    txt = Draw.new
    txt.pointsize = 30
    txt.stroke = "orange"
    txt.fill = "black"
    txt.font_weight = Magick::BoldWeight
    
    if post.compare_objects.count == 2
        
      result.annotate(title, 0,0,0,25, post.title)
    
      #Adding first object
      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_1.jpg")
      object = object.resize_to_fill(200,200)
      result = result.composite(object,100,100, Magick::OverCompositeOp)
      
      #Adding second object
      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_2.jpg")
      object = object.resize_to_fill(200,200)
      result = result.composite(object,400,100, Magick::OverCompositeOp)
      
      #Adding reaction image of object 1
      object = ImageList.new("public/#{post.compare_objects[0].emoticon}.jpg")
      object = object.resize_to_fill(50,50)
      result = result.composite(object,110,320, Magick::OverCompositeOp)
      
      #Adding reaction image of object 2
      object = ImageList.new("public/#{post.compare_objects[1].emoticon}.jpg")
      object = object.resize_to_fill(50,50)
      result = result.composite(object,410,320, Magick::OverCompositeOp)
      
      #Adding blank space for reaction count of option 1
      object = Magick::Image.new(120, 50) { self.background_color = "white" }
      result = result.composite(object,170,320, Magick::OverCompositeOp)
      
      #Adding blank space for reaction count of option 2
      result = result.composite(object,470,320, Magick::OverCompositeOp)
      
      #Adding name for objects
      result.annotate(txt, 0,0,100,400,post.compare_objects[0].name)
      result.annotate(txt, 0,0,400,400,post.compare_objects[1].name)

    elsif post.compare_objects.count == 3
      
      result.annotate(title, 0,0,0,25, post.title)
    
      #Adding first object
      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_1.jpg")
      object = object.resize_to_fill(180,200)
      result = result.composite(object,45,100, Magick::OverCompositeOp)
      
      #Adding second object
      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_2.jpg")
      object = object.resize_to_fill(180,200)
      result = result.composite(object,270,100, Magick::OverCompositeOp)
      
      #Adding third object
      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_3.jpg")
      object = object.resize_to_fill(180,200)
      result = result.composite(object,495,100, Magick::OverCompositeOp)
      
      #Adding reaction image of object 1
      object = ImageList.new("public/#{post.compare_objects[0].emoticon}.jpg")
      object = object.resize_to_fill(40,40)
      result = result.composite(object,50,310, Magick::OverCompositeOp)
      
      #Adding reaction image of object 2
      object = ImageList.new("public/#{post.compare_objects[1].emoticon}.jpg")
      object = object.resize_to_fill(40,40)
      result = result.composite(object,275,310, Magick::OverCompositeOp)
      
      #Adding reaction image of object 3
      object = ImageList.new("public/#{post.compare_objects[2].emoticon}.jpg")
      object = object.resize_to_fill(40,40)
      result = result.composite(object,500,310, Magick::OverCompositeOp)
      
      #Adding blank space for reaction count
      object = Magick::Image.new(120, 40) { self.background_color = "white" }
      result = result.composite(object,100,310, Magick::OverCompositeOp)
      result = result.composite(object,325,310, Magick::OverCompositeOp)
      result = result.composite(object,555,310, Magick::OverCompositeOp)
      
      #Adding name for objects
      txt = Draw.new
      result.annotate(txt,0,0,45,380,post.compare_objects[0].name)
      result.annotate(txt, 0,0,270,380,post.compare_objects[1].name)
      result.annotate(txt, 0,0,500,380,post.compare_objects[2].name)
    
    elsif post.compare_objects.count == 4
      
      title.pointsize = 35
      result.annotate(title, 0,0,0,5, post.title)
    
      #Adding compare objects' images
      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_1.jpg")
      object = object.resize_to_fill(240,120)
      result = result.composite(object,80,60, Magick::OverCompositeOp)
      
      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_2.jpg")
      object = object.resize_to_fill(240,120)
      result = result.composite(object,400,60, Magick::OverCompositeOp)
      
      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_3.jpg")
      object = object.resize_to_fill(240,120)
      result = result.composite(object,80,270, Magick::OverCompositeOp)
      
      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_4.jpg")
      object = object.resize_to_fill(240,120)
      result = result.composite(object,400,270, Magick::OverCompositeOp)
      
      #Adding reaction images
      object = ImageList.new("public/#{post.compare_objects[0].emoticon}.jpg")
      object = object.resize_to_fill(40,40)
      result = result.composite(object,90,185, Magick::OverCompositeOp)
      
      object = ImageList.new("public/#{post.compare_objects[1].emoticon}.jpg")
      object = object.resize_to_fill(40,40)
      result = result.composite(object,410,185, Magick::OverCompositeOp)
      
      object = ImageList.new("public/#{post.compare_objects[2].emoticon}.jpg")
      object = object.resize_to_fill(40,40)
      result = result.composite(object,90,395, Magick::OverCompositeOp)
      
      object = ImageList.new("public/#{post.compare_objects[3].emoticon}.jpg")
      object = object.resize_to_fill(40,40)
      result = result.composite(object,410,395, Magick::OverCompositeOp)
      #Adding blank space for reaction count of option 1
      object = Magick::Image.new(160, 40) { self.background_color = "white" }
      result = result.composite(object,140,185, Magick::OverCompositeOp)
      result = result.composite(object,460,185, Magick::OverCompositeOp)
      result = result.composite(object,140,395, Magick::OverCompositeOp)
      result = result.composite(object,460,395, Magick::OverCompositeOp)
      
      #Adding name for objects
      txt.pointsize = 28
      result.annotate(txt, 0,0,120,50,post.compare_objects[0].name)
      result.annotate(txt, 0,0,480,50,post.compare_objects[1].name)
      result.annotate(txt, 0,0,120,260,post.compare_objects[2].name)
      result.annotate(txt, 0,0,480,260,post.compare_objects[3].name)

    elsif post.compare_objects.count == 5
    elsif post.compare_objects.count == 6
    end
    
    #For saving image
    result.write("public/uploads/post/#{post.id}/frame.jpg")
    
    # post.duration.to_i - Time.new(2000).to_i - 19800
    
    result = %x[ffmpeg -loop 1 -re -i "public/uploads/post/#{post.id}/frame2.jpg" -pix_fmt yuv420p -profile:v baseline -s 1280x720 -bufsize 6000k -vb 400k -maxrate 1500k -deinterlace -vcodec libx264 -preset veryfast -g 30 -r 30 -f flv "rtmp://rtmp-api.facebook.com:80/rtmp/1810735672499547?ds=1&s_l=1&a=ATh9TTkOpBrcwQdU"]
    
    send_data result.to_blob, :stream => "false", :filename => "test.jpg", :type => "image/jpeg", :disposition => "inline"
  end

end