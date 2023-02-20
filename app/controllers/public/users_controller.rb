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
    @user = User.find(params[:id])
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
