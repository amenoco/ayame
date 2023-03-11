class Public::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @now = Time.now

  end

  def my
    @user = current_user
    @posts = @user.posts
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
        redirect_to users_path
    else
      @user.image = image
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :address, :is_deleted)
  end
  
end
