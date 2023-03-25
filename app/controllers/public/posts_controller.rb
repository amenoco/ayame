class Public::PostsController < PublicController
  before_action :is_matching_login_user, only: [:edit]
  
  def new
    @post = Post.new
  end

  def index
    @post = Post.published
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
    @posts = @post.user
    @post_comment = PostComment.new
    @post_comments = @post.post_comments
    @now = Time.now
    current_user.notifications.where(post_comment_id: @post_comments.pluck(:id)).update_all(already_read: true)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    
    @post.save
    if @post.save
      redirect_to post_path(@post.id)
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
    redirect_to root_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :text, :category_id, :profile_image, :is_published_flag, images: []) #categoryを追加
  end
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
  def is_matching_login_user
    post = Post.find(params[:id])
    if post.user_id != current_user.id
      redirect_to root_path
    end
  end
end
