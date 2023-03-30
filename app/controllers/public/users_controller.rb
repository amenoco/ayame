class Public::UsersController < PublicController
  before_action :set_user, only: [:favorites]
  def new
    @user = User.new
  end

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.published
    @now = Time.now
  end

  def my
    @user = current_user
    @posts = @user.posts
    @now = Time.now 
    @category_posts =  Category.includes(:posts).map{|o| {category: o, posts: o.posts } }
    @category_id =  0
  end

  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    @now = Time.now 
  end

  def edit
    @user = current_user
  end 

  def create
    @user = User.new(user_params)
    # インスタンスの保存に成功した場合の処理
    image = params[:user][:profile_image]
    hash = SecureRandom.hex(10)
    @user.image = "#{@user.name}_#{hash}.jpg" if image
    if @user.save
      write_image(@user.image, image) if image
      flash[:success] = "ユーザを登録しました"
      redirect_to root

    # インスタンスの保存に失敗した場合の処理
    else
       @user.user_image = image if image
      flash[:danger] = "ユーザの登録に失敗しました"
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    image = params[:image]
    hash = SecureRandom.hex(10)
    @user.image = "#{@user.name}_#{hash}.jpg" if image
    if @user.update!(user_params)
        redirect_to my_page_path
    else
      @user.image = image
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
  end
  
  def unsudscribe
    @user = current_user
  end

  def withdraw
     @user = current_user
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  def notifications
    @notifications =  current_user.unread_notifications.includes(:post_comment)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :address, :is_deleted, :profile_image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path
    end
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
