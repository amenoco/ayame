class PublicController < ApplicationController
    #before_action :authenticate_user!, except: [:top]
    #before_action :configure_permitted_parameters, if: :devise_controller?
    # before_action :is_matching_login_user, only: [:edit, :update]
  
  protected

  #def configure_permitted_parameters
  #  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address])
  #end
  
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # before_action :set_user

  def reject_user
    @user = User.find_by(name: params[:user][:name])
    if @user 
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_user_registration
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end
end