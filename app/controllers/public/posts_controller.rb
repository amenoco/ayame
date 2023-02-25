class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end

  def index
    #byebug
    if params[:category].nil?
      @posts = Post.all
      @category_name = '全体'
    elsif params[:category]
      @category_name = params[:category]
      @posts = Category.find_by(name: @category_name).posts
    end
  end

  def show
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    #byebug
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :text, :category_id, :images) #categoryを追加
  end
end
