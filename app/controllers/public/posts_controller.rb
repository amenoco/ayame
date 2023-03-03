class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end

  def index
    @posts = Post.left_joins(:category).all
    @category_name = '全体'

    if params[:category] != nil
      @posts = @posts.where(category: {name: params[:category]})
      @category_name = params[:category]
    end
    if params[:search] != nil
      @posts = @posts.where(['text LIKE ?', "%#{params[:search]}%"])
    end

#    @post = Post.search(params[:search])
  
    #byebug
#    if params[:category].nil?
#      @posts = Post.all
#    elsif params[:category]
#      @category_name = params[:category]
#      @posts = Category.find_by(name: @category_name).posts
#    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    
    @post.save
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_path(@post.id)
    flash[:notice] ="You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :text, :category_id, images: []) #categoryを追加
  end
end
