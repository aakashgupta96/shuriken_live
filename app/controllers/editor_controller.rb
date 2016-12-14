class EditorController < ApplicationController
	
	require "RMagick"
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
      
      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_1.jpg")
      object = object.resize_to_fill(200,200)
      result = background.composite(object,100,100, Magick::OverCompositeOp)
      
      object = ImageList.new("public/#{post.compare_objects[0].emoticon}.jpg")
      object = object.resize_to_fill(50,50)
      result = result.composite(object,110,320, Magick::OverCompositeOp)
      
      object = Magick::Image.new(120, 50) { self.background_color = "white" }
      result = result.composite(object,170,320, Magick::OverCompositeOp)
      result = result.composite(object,470,320, Magick::OverCompositeOp)
      
      
      object = ImageList.new("public/uploads/post/#{post.id}/objects/large_2.jpg")
      object = object.resize_to_fill(200,200)
      result = result.composite(object,400,100, Magick::OverCompositeOp)
      
      object = ImageList.new("public/#{post.compare_objects[1].emoticon}.jpg")
      object = object.resize_to_fill(50,50)
      result = result.composite(object,410,320, Magick::OverCompositeOp)
      
      txt = Draw.new
      result.annotate(txt, 0,0,100,400,post.compare_objects[0].name){
      txt.pointsize = 30
      txt.stroke = "orange"
      txt.fill = "black"
      txt.font_weight = Magick::BoldWeight
      }
   
      result.annotate(txt, 0,0,400,400,post.compare_objects[1].name)

    elsif post.compare_objects.count == 3

    elsif post.compare_objects.count == 4

    elsif post.compare_objects.count == 5
    elsif post.compare_objects.count == 6
    end
    
    #For saving image
    result.write("public/uploads/post/#{post.id}/frame.jpg")
    
    #result = %x[ffmpeg -loop 1 -i "public/uploads/post/#{post.id}/frame.jpg" -c:v libx264 -t 60 -pix_fmt yuv420p -strict -2 -f flv "rtmp://rtmp-api.facebook.com:80/rtmp/1809657149274066?ds=1&s_l=1&a=ATgU1QhVJ7z-nQpl"]
    
    send_data result.to_blob, :stream => "false", :filename => "test.jpg", :type => "image/jpeg", :disposition => "inline"
  end

end