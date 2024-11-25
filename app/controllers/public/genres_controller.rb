class Public::GenresController < ApplicationController

  def index
   @genres = Tag.all
  end

  def show
    @genre = Genre.find(params[:genre_id])
    @posts = @genre.posts
  
    case params[:sort]
    when 'newest'
      @posts = @posts.order(created_at: :desc).page(params[:page]).per(9)
    when 'oldest'
      @posts = @posts.order(created_at: :asc).page(params[:page]).per(9)
    when 'highest_star'
      @posts = @posts.order(star: :desc).page(params[:page]).per(9)
    else
      @posts = @posts.page(params[:page]).per(9)
    end
  end

end
