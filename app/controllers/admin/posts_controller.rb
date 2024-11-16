class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
   @posts = Post.page(params[:page])
   end

  def show
   @post = Post.find(params[:id])
   @comment = Comment.new
  end 

  def edit
    @posts = Post.find(params[:id])
   end
 
   def update
    @posts = Post.find(params[:id])
     if @posts.update(post_params)
      flash[:notice] = ' 更新に成功しました。'
      redirect_to admin_post_path(@posts)
      else
      flash[:error] = ' 更新に失敗しました。'
      render :edit
     end    
   end
 
   def destroy
     @posts = Post.find(params[:id])
     @posts.destroy
     flash[:notice] = ' 削除に成功しました。'
     redirect_to admin_posts_path
   end

   private

   def post_params
     params.require(:post).permit(:user_id, :genre_id, :caption, :title, :body, :address, images: [])
   end
 end
