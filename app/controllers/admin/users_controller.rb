class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  layout 'admin'

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @works = @user.works
    @works_page = Work.page(params[:page]).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(admin_user_params)
      flash[:notice] = "プロフィールを編集しました"
      redirect_to admin_user_path(@user)
    else
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
  end

  def withdraw
    user = User.find(params[:user_id])
    user.update(is_deleted: true)
    flash[:notice] = "退会を実行しました"
    redirect_to admin_users_path
  end

  private

  def admin_user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
