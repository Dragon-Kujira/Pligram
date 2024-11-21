class Public::PostsController < ApplicationController

  def new
   @post = Post.new
   @tags = Tag.all
  end

  def create
    @post = Post.new(post_params)

    # 新しいタグの追加
    if params[:post][:new_tags].present?
      new_tags = params[:post][:new_tags].split(',').map(&:strip)
      new_tags.each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name)
        @post.tags << tag
      end
    end

    if @post.save
      redirect_to post_path(@post), notice: '投稿が作成されました。'
    else
      @tags = Tag.all
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
    params.require(:post).permit(:user_id, :genre_id, :tag_names, :caption, :body, :address, :star, tag_ids: [], images: [])
  end
end