class UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.page(params[:page]).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    if @user == @user.guest_user?
      @user = guestuserexit
    end
    @works = @user.works
    @works_page = Work.page(params[:page]).order(created_at: :desc)
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールを編集しました"
      redirect_to user_path(current_user)
    else
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
  end

  private

  def ensure_guest_user
    @user = current_user
    if @user.guest_user?
      flash[:alert] = "利用できません"
      redirect_to user_path(current_user)
    end
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      flash[:alert] = "利用できません"
      redirect_to homes_top_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
