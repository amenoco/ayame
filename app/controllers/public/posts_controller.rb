class Public::PostsController < ApplicationController
  
  def all
    @alls = Post.where(category:"all")
  end

  def age
    @ages = Post.where(category:"age")
  end

  def region
    @regions = Post.where(category:"region")
  end
  
  def infomation
    @infomations = Post.where(category:"infomation")
  end

  def question
    @questions = Post.where(category:"question")
  end
  
  
  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
  
  private
  
  def post_params
    params.require(:post).permit(:cotent,:category) #categoryを追加
  end
end
