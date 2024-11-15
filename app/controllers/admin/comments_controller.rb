class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

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
