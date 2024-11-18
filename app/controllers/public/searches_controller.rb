class Public::SearchesController < ApplicationController

  def search
    @query = params[:query] # 検索ワード
    if @query.present?
      @users = User.where("name LIKE ?", "%#{@query}%")
      @posts = Post.where("caption LIKE ?", "%#{@query}%")
      @total_results = @users.size + @posts.size # 結果の件数
    else
      flash[:error] = "検索ワードを入力してください。"
      redirect_back(fallback_location: root_path)
    end
  end
end