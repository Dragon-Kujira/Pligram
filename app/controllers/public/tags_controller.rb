class Public::TagsController < ApplicationController

  def index
    @tags = Tag.all
  end
 
  def show
    @tag = Tag.find(params[:tag_id])
    case params[:sort]
    when 'newest'
      @posts = @tag.posts.order(created_at: :desc).page(params[:page]).per(9)
    when 'oldest'
      @posts = @tag.posts.order(created_at: :asc).page(params[:page]).per(9)
    when 'highest_star'
      @posts = @tag.posts.order(star: :desc).page(params[:page]).per(9)
    else
      @posts = @tag.posts.order(created_at: :desc).page(params[:page]).per(9)
    end
  end
  
end
