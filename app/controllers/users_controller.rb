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
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
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
      redirect_to user_path(current_user), notice: "guestuserはプロフィール編集画面へ遷移できません。"
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
