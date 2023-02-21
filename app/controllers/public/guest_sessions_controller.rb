class Public::GuestSessionsController < ApplicationController
    def login_required
    skip_before_action :login_required
    end
    def create
        user = User.find_by(email: "guest@example.com")
        if user.present?
         sign_in user
        redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
        else
            redirect_to root_path
        end
    end
    def new
    end
   
end