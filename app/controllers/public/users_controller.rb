class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  
  def userposts
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    if params[:id].present?
      # 他のユーザーのページ
      @user = User.find(params[:id])
    else
      # 自分のマイページ
      @user = current_user
    end
  end

  def edit
   @user = current_user  
  end

  def update
    @user = current_user  
    if @user.update(user_params)
     flash[:notice] = "ユーザー情報を編集しました。"
     redirect_to my_page_path
    else
      flash[:error] = ' 更新に失敗しました。'
      render :edit
     end    
   end
  
  def unsubscribe
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行しました。"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image)
  end
end
