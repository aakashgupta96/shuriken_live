class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def dashboard
  
  end

  def objects
    @post = Post.new(post_params)
    @post.save
    @compare_object = CompareObject.new#Array.new
    # @post.comparisons.times do|i|
    #   @compare_object[i] = CompareObject.new
    # end
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
  def edit
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
