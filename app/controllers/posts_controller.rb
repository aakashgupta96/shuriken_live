class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :postid, :destroy]

  require "RMagick"
  require 'koala'
  include Magick


  def dashboard
  end

  def objects
    @post = Post.new(post_params)
    @post.save
    @compare_object = CompareObject.new
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.new
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    #byebug
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  def postid
    #byebug
  end

  def save
      @post.fb_id = params[:fb_id]
      @post.save 
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.find(params[:post_id])
    @post.comparisons.times do |i|
      @object = CompareObject.new(compare_object_params i)
      @object.post_id = @post.id
      @post.compare_objects << @object
    end
    
    respond_to do |format|
      if @post.save
        createFrame
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def createFrame 
    post = Post.last
    background = ImageList.new("public/uploads/post/#{post.id}/background/large_1.jpg")
    result = background
    
    # Adding title to background
    txt = Draw.new
    result.annotate(txt, 0,0,0,25, post.title){
    txt.gravity = Magick::NorthGravity
    txt.pointsize = 30
    txt.stroke = "#000000"
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
      result.annotate(txt, 0,0,50,375,post.compare_objects[0].name){
      txt.pointsize = 20
      txt.stroke = "#000000"
      txt.fill = "#ffffff"
      #txt.font_weight = Magick::BoldWeight
      }
   

    elsif post.compare_objects.count == 3

    elsif post.compare_objects.count == 4

    elsif post.compare_objects.count == 5
    elsif post.compare_objects.count == 6
    end
    
    #For saving image
    result.write("public/uploads/post/#{post.id}/frame.jpg")

    #send_data result.to_blob, :stream => "false", :filename => "test.jpg", :type => "image/jpeg", :disposition => "inline"
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:key,:title,:duration,:start_time,:background,:comparisons)
    end

    def compare_object_params i
      params.require(:compare_object).require("#{i}").permit(:name,:emoticon,:image)
    end
end
