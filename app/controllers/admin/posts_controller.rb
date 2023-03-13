class Admin::PostsController < ApplicationController
 
  def index
    @posts = Post.all
    @post = @posts
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
  end

  def update
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :text, :category_id, images: []) #categoryを追加
  end
  
end
