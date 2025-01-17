class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
   end
 
   def edit
    @user = User.find(params[:id])
   end
 
   def update
    @user = User.find(params[:id])
     if @user.update(user_params)
      flash[:notice] = "ユーザー情報を編集しました。"
      redirect_to admin_users_path(@user)
     else
      render 'edit'
     end 
   end


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = ' ユーザー情報の削除に成功しました。'
    redirect_to admin_users_path
  end

 
   private
 
   def user_params
     params.require(:user).permit(:name, :email, :is_active)
   end
 end
