class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @comment = Comment.find(params[:id])
    post_id = @comment.post_id
    @comment.destroy
    flash[:success] = "コメントを削除しました。"
    redirect_to admin_post_path(post_id)
  end


  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :body)
  end
end
