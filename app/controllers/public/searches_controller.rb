class Public::SearchesController < ApplicationController

  def search
    @query = params[:query]
    if @query.present?
      @users = User.where("name LIKE ?", "%#{@query}%").page(params[:page]).per(9)
      @posts = Post.where("caption LIKE ? OR body LIKE ?", "%#{@query}%", "%#{@query}%").page(params[:page]).per(9)
      @total_results = @users.total_count + @posts.total_count
    else
      flash[:error] = "検索ワードを入力してください。"
      redirect_back(fallback_location: root_path)
    end
  end
end