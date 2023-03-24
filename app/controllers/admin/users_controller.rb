class Admin::UsersController < ApplicationController

  def index
    @user = User.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        redirect_to admin_users_path
    else
      render :edit
    end
    
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :encrypted_password, :address, :is_deleted)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path
    end
  end
end
