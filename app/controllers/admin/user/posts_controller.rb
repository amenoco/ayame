class Admin::User::PostsController < AdminController
 
  def index
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(4)
    # @post = @posts
    @now = Time.now
  end

  # def show
  #   @post = Post.find(params[:id])
  #   @now = Time.now
  # end

  # def edit
  #   @post = Post.find(params[:id])
  # end

  # def create
  #   @post = Post.new(post_params)
  #   @post.user = current_user
  # end

  # def update
  #   @post = Post.find(params[:id])
  # end

  # def destroy
  #   @post = Post.find(params[:id])
  #   @post.destroy
  # end
  
  # private
  
  # def post_params
  #   params.require(:post).permit(:title, :text, :category_id, images: []) #categoryを追加
  # end
  
end
