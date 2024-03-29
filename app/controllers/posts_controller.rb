class PostsController < ApplicationController
  before_action :set_post, only: [:publish,:create,:preview, :edit_title, :edit, :update, :video_id, :destroy]
  before_action :authenticate_user!, only: []
  skip_before_filter :set_mobile_format

  include Frame

  def home
  end
  
  def steps
  end

  def objects
    @post = Post.new(post_params)
    begin
      x = params[:post][:video_id].split("%2F")[5]
    rescue
      redirect_to new_post_path, alert: "Invalid video embed link"
      return
    end
    if x.nil?
      redirect_to new_post_path, alert: "Invalid video embed link"
      return
    end
    @post.video_id = x
    @post.save
    @compare_object = CompareObject.new
  end

  def new
    @post = Post.new
  end

  def preview
    
  end


  def publish 
    if workers_available? 
      Resque.enqueue(StartStream,@post.id)
      Resque.enqueue(UpdateFrame,@post.id)
      Resque.enqueue(NotifyAdmins,@post.id)
    else
      redirect_to root_path, alert: "Sorry! Can't process you request"
      return
    end
  end

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

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    
    def workers_available?
      start = 0
      update = 0
      Resque::Worker.all.each do |worker|
        
        unless worker.working?
          start = 1 if worker.queues.first == "start_stream"
          update = 1 if worker.queues.first == "update_frame"
        end
        return true if start==1 and update==1
      end
      return false
    end

    def set_post
      @post = Post.find_by_id(params[:id]) 
      if @post.nil?
        redirect_to root_path, alert: "Invalid URL"
      end
    end

    def post_params
      params.require(:post).permit(:key,:title,:duration,:start_time,:background,:audio,:comparisons)
    end

    def compare_object_params i
      params.require(:compare_object).require("#{i}").permit(:name,:emoticon,:image)
    end
end
