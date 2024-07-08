class UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  
  def index
  end

  def show
    @user = User.find(params[:id])
    if @user != @user.guest_user?
      @user = current_user
    end
  end

  def edit
  end
  
  private
  
  def ensure_guest_user
    @user = current_user
    if @user.guest_user?
      redirect_to user_path(current_user), notice: "guestuserはプロフィール編集画面へ遷移できません。"
    end
  end
end
