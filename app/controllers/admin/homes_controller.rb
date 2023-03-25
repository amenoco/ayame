class Admin::HomesController < AdminController
  def top
    @user = User.new
    @users = User.all
  end
end