class Public::PostsController < ApplicationController

  def new
   @post = Post.new
   @tags = Tag.all
  end

  def create
    @post = Post.new(post_params.except(:new_tags))
    @post.user_id = current_user.id
  
    if @post.save
      if params[:post][:new_tags].present?
        new_tags = params[:post][:new_tags].map(&:strip) # 配列の各要素に strip メソッドを適用
        new_tags.each do |tag_name|
          tag = Tag.find_or_create_by(name: tag_name)
          @post.tags << tag
        end
      end
      redirect_to post_path(@post), notice: '投稿が作成されました。'
    else
      @tags = Tag.all
      render :new
    end
  end
  
  def index
    case params[:sort]
    when 'newest'
      @posts = Post.order(created_at: :desc).page(params[:page]).per(9)
    when 'oldest'
      @posts = Post.order(created_at: :asc).page(params[:page]).per(9)
    when 'highest_star'
      @posts = Post.order(star: :desc).page(params[:page]).per(9)
    else
      @posts = Post.page(params[:page]).per(9)
    end
  end

  def show
   @post = Post.find(params[:id])
   @comment = Comment.new
  end

  def edit
   @posts = Post.find(params[:id])
   @tags = Tag.all
  end

  def update
   @post = Post.find(params[:id])
    if @post.update(post_params.except(:new_tags))
      if params[:post][:new_tags].present?
        new_tags = params[:post][:new_tags].map(&:to_s).map(&:strip)
        new_tags.each do |tag_name|
          tag = Tag.find_or_create_by(name: tag_name)
          @post.tags << tag
        end
      end
      flash[:notice] = '更新に成功しました。'
      redirect_to post_path(@post)
    else
      flash[:error] = '更新に失敗しました。'
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
    params.require(:post).permit(:user_id, :genre_id, :caption, :body, :address, :star, tag_ids: [], new_tags: [], images: [])
  end
end