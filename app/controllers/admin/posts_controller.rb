class Admin::PostsController < AdminController
 
  def index
    @posts = Post.all
    @post = @posts
    @now = Time.now
    
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @now = Time.now
    @user_id = @post.user_id
    
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
  end

  def update
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    user_id = @post.user_id
    @post.destroy
    redirect_to admin_user_posts_path(user_id)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :text, :category_id, images: []) #categoryを追加
  end
  
end
