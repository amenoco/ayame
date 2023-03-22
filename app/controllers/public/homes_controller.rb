class Public::HomesController < ApplicationController
  def top
    @category_posts =  Category.includes(:posts).map{|o| {category: o, posts: o.posts.published } }
    @category_id = 0
    @search = params[:search]
    @now = Time.now
  end
  
  def search
    @category_posts =  Category.includes(:posts).map{|o| {category: o, posts: (params[:search].present? && (o.id == params[:category_id].to_i || params[:category_id].to_i == 0) ? o.posts.where('text like ?', "%#{params[:search]}%").order("id DESC") : o.posts ) } }

    @category_id = params[:category_id]
    @search = params[:search]
    render 'public/homes/search'
  end

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

  def post_params
    params.require(:post).permit(:title, :text, :category_id, images: []) #categoryを追加
  end
end
