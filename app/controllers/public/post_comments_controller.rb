class Public::PostCommentsController < PublicController
  def create
    @post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    comment.save!
     flash[:notice] = 'コメントが反映されました'
    redirect_to post_path(@post.id)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def destroy
    @post_comment = PostComment.find(params[:id])
    Notification.where(post_comment_id: @post_comment.id).destroy_all
    @post_comment.destroy
    flash[:notice] = 'コメントを削除しました'
    redirect_to post_path(params[:post_id])
  end
  
  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
