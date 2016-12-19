module Frame
	include Magick
  
	def createFrame 
	    post = Post.last
	    background = ImageList.new("public/uploads/post/#{post.id}/background/large_1.jpg")
	    result = background
	    
	    # Adding title to background
	    txt = Draw.new
	    result.annotate(txt, 0,0,0,25, post.title){
	    txt.gravity = Magick::NorthGravity
	    txt.pointsize = 40
	    txt.stroke = "black"
	    txt.fill = "#ffffff"
	    txt.font_weight = Magick::BoldWeight
	    }

	    #Adding compare objects to image formed
	    if post.compare_objects.count == 2
	      
	      #Adding first object
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_1.jpg")
	      object = object.resize_to_fill(200,200)
	      result = background.composite(object,100,80, Magick::OverCompositeOp)
	      
	      #Adding second object
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_2.jpg")
	      object = object.resize_to_fill(200,200)
	      result = result.composite(object,400,80, Magick::OverCompositeOp)
	      
	      #Adding reaction image of object 1
	      object = ImageList.new("public/#{post.compare_objects[0].emoticon}.jpg")
	      object = object.resize_to_fill(50,50)
	      result = result.composite(object,110,300, Magick::OverCompositeOp)
	      
	      #Adding reaction image of object 2
	      object = ImageList.new("public/#{post.compare_objects[1].emoticon}.jpg")
	      object = object.resize_to_fill(50,50)
	      result = result.composite(object,410,300, Magick::OverCompositeOp)
	      
	      #Adding blank space for reaction count of option 1
	      object = Magick::Image.new(120, 50) { self.background_color = "white" }
	      result = result.composite(object,170,300, Magick::OverCompositeOp)
	      
	      #Adding blank space for reaction count of option 2
	      result = result.composite(object,470,300, Magick::OverCompositeOp)
	      
	      
	      #Adding name for objects
	      txt = Draw.new
	      result.annotate(txt, 0,0,100,380,post.compare_objects[0].name){
	      txt.pointsize = 30
	      txt.stroke = "orange"
	      txt.fill = "black"
	      txt.font_weight = Magick::BoldWeight
	      }
	   
	      result.annotate(txt, 0,0,400,380,post.compare_objects[1].name)

	    elsif post.compare_objects.count == 3
	      
	      #Adding first object
	      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_1.jpg")
	      object = object.resize_to_fill(180,200)
	      result = background.composite(object,45,100, Magick::OverCompositeOp)
	      
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
	      result.annotate(txt,0,0,45,380,post.compare_objects[0].name){
	      txt.pointsize = 30
	      txt.stroke = "orange"
	      txt.fill = "black"
	      txt.font_weight = Magick::BoldWeight
	      }
	   
	      result.annotate(txt, 0,0,270,380,post.compare_objects[1].name)

	      result.annotate(txt, 0,0,500,380,post.compare_objects[2].name)
	    elsif post.compare_objects.count == 4

	    elsif post.compare_objects.count == 5
	    elsif post.compare_objects.count == 6
	    end
	    

	    #For saving image
	    result.write("public/uploads/post/#{post.id}/frame.jpg")
	    

	    txt = Draw.new
	    txt.pointsize = 30
	    txt.stroke = "orange"
	    txt.fill = "black"
	    txt.font_weight = Magick::BoldWeight
	   
	    if post.comparisons == 2
	      frame = ImageList.new("public/uploads/post/#{post.id}/frame.jpg")
	      frame.annotate(txt,0,0,200,335,"0")
	      frame.annotate(txt,0,0,500,335,"0")
	    elsif post.comparisons == 3
	      frame = ImageList.new("public/uploads/post/#{post.id}/frame.jpg")
	      frame.annotate(txt,0,0,130,340,"0")
	      frame.annotate(txt,0,0,350,340,"0")
	      frame.annotate(txt,0,0,580,340,"0")
	    elsif post.comparisons == 4
	      frame = ImageList.new("public/uploads/post/#{post.id}/frame.jpg")
	      frame.annotate(txt,0,0,160,215,"0")
	      frame.annotate(txt,0,0,480,215,"0")
	      frame.annotate(txt,0,0,160,425,"0")
	      frame.annotate(txt,0,0,480,425,"0")
	    elsif post.comparisons == 5
	    elsif post.comparisons == 6
	    end

	    frame.write("public/uploads/post/#{post.id}/frame2.jpg")
	    frame.write("app/assets/images/#{post.id}_frame.jpg")
 	end
end