class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    @comment.save
    flash[:notice] = ' コメントを投稿しました。'
    redirect_to post_path(@post)
  end

  def destroy
    flash[:notice] = ' コメントを削除しました。'
    Comment.find(params[:id]).destroy
    redirect_to admin_post_path(params[:post_id])
  end


  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :body)
  end
end
