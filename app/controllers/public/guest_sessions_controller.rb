class Public::GuestSessionsController < PublicController
  #def login_required
   # skip_before_action :login_required
  #end
    
  def create
    user = User.find_or_initialize_by(email: User.new.send(:guest_email))
    if user.new_record?
      password = Digest::MD5.new
      password.update("guest")
      user.assign_attributes(name: "ゲスト", password: password.to_s)
      user.save!
    end
    sign_in user
    flash[:notice] = 'ゲストユーザーとしてログインしました。'
    redirect_to root_path
  end
    
  def new
  end
end