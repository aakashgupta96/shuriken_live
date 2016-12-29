class PostsController < ApplicationController
  before_action :set_post, only: [:show,:publish,:create,:preview,:edit_objects, :start_update,:edit_title, :edit, :update, :video_id, :destroy]
  before_action :authenticate_user!, only: []
  include Frame

  def home
  end
  
  def steps
  end

  def objects
    @post = Post.new(post_params)
    @post.video_id = params[:post][:video_id].split("?").last.split("=").second.split("\"").first
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
    
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit_objects
    @compare_object = CompareObject.new
  end
  
  def preview
    
  end


  def publish
      Resque.enqueue(StartStream,@post.id)
  end

  def start_update
    Resque.enqueue(UpdateFrame,@post.id,(((@post.duration - 30.years).to_i)/2)+50)
    redirect_to root_path
  end
  # POST /posts
  # POST /posts.json
  def create
    @post.compare_objects.delete_all
    @post.comparisons.times do |i|
      @object = CompareObject.new(compare_object_params i)
      @object.post_id = @post.id
      @post.compare_objects << @object
    end
    respond_to do |format|
      if @post.save
        createFrame
        format.html { redirect_to frame_preview_path(@post.id)}
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
        createFrame
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



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by_id(params[:id])
      if @post.nil?
          redirect_to '/steps', alert: "Invalid Choice"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:key,:title,:duration,:start_time,:background,:comparisons)
    end

    def compare_object_params i
      params.require(:compare_object).require("#{i}").permit(:name,:emoticon,:image)
    end
end
