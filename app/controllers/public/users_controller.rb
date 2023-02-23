class Public::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    # インスタンスの保存に成功した場合の処理
    if @user.save
      flash[:success] = "ユーザを登録しました"
      redirect_to root

    # インスタンスの保存に失敗した場合の処理
    else
      flash[:danger] = "ユーザの登録に失敗しました"
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :encrypted_password, :address, :is_deleted)
  end
  
end
