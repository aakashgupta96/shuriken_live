module Frame
	include Magick
  
	def createFrame 
	    post = Post.last
	    background = ImageList.new("public/uploads/post/#{post.id}/background/large_1.png")
	    result = background
	    result.resize!(720,405)
	    
	    # Adding title to background
	    title = Draw.new
	    title.gravity = Magick::NorthGravity
	    title.pointsize = 38
	    title.stroke = "black"
	    title.fill = "white"
	    title.font_weight = Magick::BoldWeight

	    txt = Draw.new
	    txt.pointsize = 30
	    txt.stroke = "black"
	    txt.fill = "white"
	    txt.font_weight = Magick::BoldWeight
		 
	    #Adding compare objects to image formed
	    if post.compare_objects.count == 2
	      
	      result.annotate(title, 0,0,0,25, post.title)

	      #Adding first object
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_1.png")
	      object = object.resize_to_fill(200,200)
	      result = background.composite(object,100,80, Magick::OverCompositeOp)
	      
	      #Adding second object
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_2.png")
	      object = object.resize_to_fill(200,200)
	      result = result.composite(object,400,80, Magick::OverCompositeOp)
	      
	      #Adding reaction image of object 1
	      object = ImageList.new("public/#{post.compare_objects[0].emoticon}.png")
	      object = object.resize_to_fill(50,50)
	      result = result.composite(object,110,290, Magick::OverCompositeOp)
	      
	      #Adding reaction image of object 2
	      object = ImageList.new("public/#{post.compare_objects[1].emoticon}.png")
	      object = object.resize_to_fill(50,50)
	      result = result.composite(object,410,290, Magick::OverCompositeOp)
	      
	      #Adding name for objects
	      result.annotate(txt, 0,0,120,370,post.compare_objects[0].name)
	      result.annotate(txt, 0,0,420,370,post.compare_objects[1].name)

	    elsif post.compare_objects.count == 3
	      
	      result.annotate(title, 0,0,0,25, post.title)
    		
	      #Adding first object
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_1.png")
	      object = object.resize_to_fill(180,200)
	      result = background.composite(object,45,80, Magick::OverCompositeOp)
	      
	      #Adding second object
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_2.png")
	      object = object.resize_to_fill(180,200)
	      result = result.composite(object,270,80, Magick::OverCompositeOp)
	      
	      #Adding third object
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_3.png")
	      object = object.resize_to_fill(180,200)
	      result = result.composite(object,495,80, Magick::OverCompositeOp)
	      
	      #Adding reaction image of object 1
	      object = ImageList.new("public/#{post.compare_objects[0].emoticon}.png")
	      object = object.resize_to_fill(40,40)
	      result = result.composite(object,50,290, Magick::OverCompositeOp)
	      
	      #Adding reaction image of object 2
	      object = ImageList.new("public/#{post.compare_objects[1].emoticon}.png")
	      object = object.resize_to_fill(40,40)
	      result = result.composite(object,275,290, Magick::OverCompositeOp)
	      
	      #Adding reaction image of object 3
	      object = ImageList.new("public/#{post.compare_objects[2].emoticon}.png")
	      object = object.resize_to_fill(40,40)
	      result = result.composite(object,500,290, Magick::OverCompositeOp)
	      
	      #Adding name for objects
	      result.annotate(txt,0,0,55,360,post.compare_objects[0].name) 
	      result.annotate(txt, 0,0,280,360,post.compare_objects[1].name)
	      result.annotate(txt, 0,0,510,360,post.compare_objects[2].name)
	    elsif post.compare_objects.count == 4
	    	
	      title.pointsize = 32
	      result.annotate(title, 0,0,0,5, post.title)
	    
	      #Adding compare objects' images
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_1.png")
	      object = object.resize_to_fill(240,100)
	      result = result.composite(object,80,70, Magick::OverCompositeOp)
	      
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_2.png")
	      object = object.resize_to_fill(240,100)
	      result = result.composite(object,400,70, Magick::OverCompositeOp)
	      
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_3.png")
	      object = object.resize_to_fill(240,100)
	      result = result.composite(object,80,250, Magick::OverCompositeOp)
	      
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_4.png")
	      object = object.resize_to_fill(240,100)
	      result = result.composite(object,400,250, Magick::OverCompositeOp)
	      
	      #Adding reaction images
	      object = ImageList.new("public/#{post.compare_objects[0].emoticon}.png")
	      object = object.resize_to_fill(30,30)
	      result = result.composite(object,90,175, Magick::OverCompositeOp)
	      
	      object = ImageList.new("public/#{post.compare_objects[1].emoticon}.png")
	      object = object.resize_to_fill(30,30)
	      result = result.composite(object,410,175, Magick::OverCompositeOp)
	      
	      object = ImageList.new("public/#{post.compare_objects[2].emoticon}.png")
	      object = object.resize_to_fill(30,30)
	      result = result.composite(object,90,355, Magick::OverCompositeOp)
	      
	      object = ImageList.new("public/#{post.compare_objects[3].emoticon}.png")
	      object = object.resize_to_fill(30,30)
	      result = result.composite(object,410,355, Magick::OverCompositeOp)
	      #Adding blank space for reaction count of option 1
	      # object = Magick::Image.new(160, 40) { self.background_color = "white" }
	      # result = result.composite(object,140,185, Magick::OverCompositeOp)
	      # result = result.composite(object,460,185, Magick::OverCompositeOp)
	      # result = result.composite(object,140,395, Magick::OverCompositeOp)
	      # result = result.composite(object,460,395, Magick::OverCompositeOp)
	      
	      #Adding name for objects
	      txt.pointsize = 28
	      result.annotate(txt, 0,0,100,60,post.compare_objects[0].name)
	      result.annotate(txt, 0,0,440,60,post.compare_objects[1].name)
	      result.annotate(txt, 0,0,100,240,post.compare_objects[2].name)
	      result.annotate(txt, 0,0,440,240,post.compare_objects[3].name)

	    elsif post.compare_objects.count == 5

	      title.pointsize = 32
	      result.annotate(title, 0,0,0,5, post.title)
	    
	      #Adding objects' image
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_1.png")
	      object = object.resize_to_fill(180,100)
	      result = result.composite(object,45,70, Magick::OverCompositeOp)
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_2.png")
	      object = object.resize_to_fill(180,100)
	      result = result.composite(object,270,70, Magick::OverCompositeOp)
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_3.png")
	      object = object.resize_to_fill(180,100)
	      result = result.composite(object,495,70, Magick::OverCompositeOp)
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_4.png")
	      object = object.resize_to_fill(180,100)
	      result = result.composite(object,130,250, Magick::OverCompositeOp)
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_5.png")
	      object = object.resize_to_fill(180,100)
	      result = result.composite(object,370,250, Magick::OverCompositeOp)
	      
	      #Adding reaction images
	      object = ImageList.new("public/#{post.compare_objects[0].emoticon}.png")
	      object = object.resize_to_fill(30,30)
	      result = result.composite(object,50,175, Magick::OverCompositeOp)
	      object = ImageList.new("public/#{post.compare_objects[1].emoticon}.png")
	      object = object.resize_to_fill(30,30)
	      result = result.composite(object,275,175, Magick::OverCompositeOp)
	      object = ImageList.new("public/#{post.compare_objects[2].emoticon}.png")
	      object = object.resize_to_fill(30,30)
	      result = result.composite(object,500,175, Magick::OverCompositeOp)
	      object = ImageList.new("public/#{post.compare_objects[3].emoticon}.png")
	      object = object.resize_to_fill(30,30)
	      result = result.composite(object,130,355, Magick::OverCompositeOp)
	      object = ImageList.new("public/#{post.compare_objects[4].emoticon}.png")
	      object = object.resize_to_fill(30,30)
	      result = result.composite(object,375,355, Magick::OverCompositeOp)
	      
	      #Adding blank space for reaction count
	      # object = Magick::Image.new(120, 40) { self.background_color = "white" }
	      # result = result.composite(object,100,310, Magick::OverCompositeOp)
	      # result = result.composite(object,325,310, Magick::OverCompositeOp)
	      # result = result.composite(object,555,310, Magick::OverCompositeOp)
	      
	      #Adding name for objects
	      txt.pointsize = 22;
	      result.annotate(txt,0,0,45,60,post.compare_objects[0].name)
	      result.annotate(txt,0,0,270,60,post.compare_objects[1].name)
	      result.annotate(txt,0,0,500,60,post.compare_objects[2].name)
	      result.annotate(txt,0,0,130,240,post.compare_objects[3].name)
	      result.annotate(txt,0,0,370,240,post.compare_objects[4].name)
	    elsif post.compare_objects.count == 6

	   	  title.pointsize = 32
	      result.annotate(title, 0,0,0,5, post.title)
	    
	      #Adding objects' image
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_1.png")
	      object = object.resize_to_fill(180,100)
	      result = result.composite(object,45,70, Magick::OverCompositeOp)
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_2.png")
	      object = object.resize_to_fill(180,100)
	      result = result.composite(object,270,70, Magick::OverCompositeOp)
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_3.png")
	      object = object.resize_to_fill(180,100)
	      result = result.composite(object,495,70, Magick::OverCompositeOp)
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_4.png")
	      object = object.resize_to_fill(180,100)
	      result = result.composite(object,45,250, Magick::OverCompositeOp)
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_5.png")
	      object = object.resize_to_fill(180,100)
	      result = result.composite(object,270,250, Magick::OverCompositeOp)
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_6.png")
	      object = object.resize_to_fill(180,100)
	      result = result.composite(object,495,250, Magick::OverCompositeOp)
	      
	      #Adding reaction images
	      object = ImageList.new("public/#{post.compare_objects[0].emoticon}.png")
          object = object.resize_to_fill(30,30)
          result = result.composite(object,50,175, Magick::OverCompositeOp)
          object = ImageList.new("public/#{post.compare_objects[1].emoticon}.png")
          object = object.resize_to_fill(30,30)
          result = result.composite(object,275,175, Magick::OverCompositeOp)
          object = ImageList.new("public/#{post.compare_objects[2].emoticon}.png")
          object = object.resize_to_fill(30,30)
          result = result.composite(object,500,175, Magick::OverCompositeOp)
          object = ImageList.new("public/#{post.compare_objects[3].emoticon}.png")
          object = object.resize_to_fill(30,30)
          result = result.composite(object,50,355, Magick::OverCompositeOp)
          object = ImageList.new("public/#{post.compare_objects[4].emoticon}.png")
          object = object.resize_to_fill(30,30)
          result = result.composite(object,275,355, Magick::OverCompositeOp)
          object = ImageList.new("public/#{post.compare_objects[5].emoticon}.png")
          object = object.resize_to_fill(30,30)
          result = result.composite(object,500,355, Magick::OverCompositeOp)
        
	      #Adding blank space for reaction count
	      # object = Magick::Image.new(120, 40) { self.background_color = "white" }
	      # result = result.composite(object,100,310, Magick::OverCompositeOp)
	      # result = result.composite(object,325,310, Magick::OverCompositeOp)
	      # result = result.composite(object,555,310, Magick::OverCompositeOp)
	      
	      #Adding name for objects
	      txt.pointsize = 22;
	      result.annotate(txt,0,0,45,60,post.compare_objects[0].name)
	      result.annotate(txt,0,0,270,60,post.compare_objects[1].name)
	      result.annotate(txt,0,0,500,60,post.compare_objects[2].name)
	      result.annotate(txt,0,0,45,240,post.compare_objects[3].name)
	      result.annotate(txt,0,0,270,240,post.compare_objects[4].name)
	      result.annotate(txt,0,0,500,240,post.compare_objects[5].name)

	    end
	    

	    #For saving image
	    result.write("public/uploads/post/#{post.id}/frame.png")
	    

	    txt = Draw.new
	    txt.pointsize = 30
	    txt.stroke = "black"
	    txt.fill = "white"
	    txt.font_weight = Magick::BoldWeight
	   	
	   	#Adding initial reactions count
	    frame = ImageList.new("public/uploads/post/#{post.id}/frame.png")
	    if post.comparisons == 2
	      frame.annotate(txt,0,0,200,325,"0")
	      frame.annotate(txt,0,0,500,325,"0")
	    elsif post.comparisons == 3
	      frame.annotate(txt,0,0,130,320,"0")
	      frame.annotate(txt,0,0,350,320,"0")
	      frame.annotate(txt,0,0,580,320,"0")
	    elsif post.comparisons == 4
	      frame.annotate(txt,0,0,160,200,"0")
	      frame.annotate(txt,0,0,480,200,"0")
	      frame.annotate(txt,0,0,160,380,"0")
	      frame.annotate(txt,0,0,480,380,"0")
	    elsif post.comparisons == 5
	      frame.annotate(txt,0,0,130,200,"0")
       	  frame.annotate(txt,0,0,360,200,"0")
      	  frame.annotate(txt,0,0,580,200,"0")
      	  frame.annotate(txt,0,0,220,380,"0")
      	  frame.annotate(txt,0,0,460,380,"0")
	    elsif post.comparisons == 6
	      frame.annotate(txt,0,0,130,200,"0")
          frame.annotate(txt,0,0,360,200,"0")
          frame.annotate(txt,0,0,580,200,"0")
      	  frame.annotate(txt,0,0,130,380,"0")
    	  frame.annotate(txt,0,0,360,380,"0")
          frame.annotate(txt,0,0,580,380,"0")
	    end

	    frame.write("public/uploads/post/#{post.id}/frame2.png")
	    frame.write("app/assets/images/#{post.id}_frame.png")
 	end
end