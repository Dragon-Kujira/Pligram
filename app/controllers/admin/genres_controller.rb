class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
    flash[:notice] = 'ジャンルを投稿しました。' 
     redirect_to admin_genres_path
    else
    @renres = Genre.all
    flash[:error] = 'ジャンルの投稿に失敗しました。' 
     render 'index'
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    flash[:notice] = 'ジャンルを編集しました。' 
    redirect_to admin_genres_path
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    flash[:notice] = 'ジャンルを削除しました。'
    redirect_to admin_genres_path
  end

private

  def genre_params
  params.require(:genre).permit(:name)
  end
end