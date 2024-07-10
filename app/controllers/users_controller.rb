class UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

  def index
  end

  def show
    @user = User.find(params[:id])
    if @user == @user.guest_user?
      @user = guestuser
    end
    @works = @user.works
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(current_user)
  end

  private

  def ensure_guest_user
    @user = current_user
    if @user.guest_user?
      redirect_to user_path(current_user), notice: "guestuserはプロフィール編集画面へ遷移できません。"
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
