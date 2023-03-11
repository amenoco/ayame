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

  end

  def show
    @post = Post.find(params[:id])
    # @post = Post.new
    @post_comment = PostComment.new
    @now = Time.now
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
    flash[:notice] ="投稿できました"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
    
    @PostComment = PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(params[:post_id])
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :text, :category_id, images: []) #categoryを追加
  end
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
