class AdminController < ApplicationController
    before_action :authenticate_admin!
    # before_action :configure_permitted_parameters, if: :devise_controller?
    # before_action :is_matching_login_user, only: [:edit, :update]
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address])
  end
  
  def log_in(user)
    session[:user_id] = user.id
  end
    
  def update
   contact = Contact.find(params[:id]) #contact_mailer.rbの引数を指定
   contact.update(contact_params)
   user = contact.user
   ContactMailer.send_when_admin_reply(user, contact).deliver
  end
end