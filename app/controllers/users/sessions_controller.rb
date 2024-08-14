class Users::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: "guestuserでログインしました"
  end
  
  private
  
  def user_state
    user = User.find_by(email: params[:user][:email])
    return if user.nil?
    return unless user.valid_password?(params[:user][:password])
    return if user.is_deleted == false
    if user.is_deleted == true
      flash[:alert] = "新規登録を行ってください"
      redirect_to new_user_registration_path
    end
  end
end