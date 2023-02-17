class GuestSessionsController < ApplicationController
    def login_required
    skip_before_action :login_required
    end
    def create
        user = User.find_by(email: "guest@example.com")
        log_in(user)
      session[:user_id] = user.id
    flash[:success] = 'ゲストユーザーでログインしました'
    flash[:warning] = 'よろしくお願いします！'
    redirect_to root_path
    end
    def new
    end
end