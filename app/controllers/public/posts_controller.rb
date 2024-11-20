class Public::PostsController < ApplicationController

  def new
   @post = Post.new
  end

  def create
   @post = Post.new(post_params)
   @post.user = current_user
    if @post.save
    flash[:notice] = '登録成功！'
    redirect_to post_path(@post)
     else
    flash[:notice] = '登録エラー！'
    render :new
   end
  end

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
     redirect_to post_path(@posts)
     else
     flash[:error] = ' 更新に失敗しました。'
     render :edit
    end    
  end

  def destroy
    @posts = Post.find(params[:id])
    @posts.destroy
    flash[:notice] = ' 削除に成功しました。'
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :genre_id, :tag_names, :caption, :body, :address, :star, images: [])
  end
end