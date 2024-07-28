class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  layout 'admin'

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
    @user.update(admin_user_params)
    redirect_to admin_user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました。"
  end

  private

  def admin_user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
