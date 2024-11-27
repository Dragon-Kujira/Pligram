class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    @comment.save
    @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(5)
  
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post # 関連する投稿を取得
    @comment.destroy
    @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(5) # 再取得

  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :body)
  end
end
