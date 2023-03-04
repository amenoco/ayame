class Public::HomesController < ApplicationController
  def top
     @posts = Post.left_joins(:category).all
    @category_name = '全体'

    if params[:category] != nil
      @posts = @posts.where(category: {name: params[:category]})
      @category_name = params[:category]
    end
    if params[:search] != nil
      @posts = @posts.where(['text LIKE ?', "%#{params[:search]}%"])
    end
    
  end

  def post_params
    params.require(:post).permit(:title, :text, :category_id, images: []) #categoryを追加
  end
end
