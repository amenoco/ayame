class PublicController < ApplicationController
    #before_action :authenticate_user!, except: [:top]
    before_action :configure_permitted_parameters, if: :devise_controller?
    # before_action :is_matching_login_user, only: [:edit, :update]
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address])
  end
  
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # before_action :set_user

  # def create
  #   if @user.save #ユーザーのインスタンスが新しく生成されて保存されたら
  #     NotificationMailer.send_when_signup(@user).deliver #確認メールを送信
  #     redirect_to @user
  #   else
  #     render 'new'
  #   end
  # end
end