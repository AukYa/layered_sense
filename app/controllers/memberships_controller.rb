class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    membership = current_user.memberships.new(group_id: params[:group_id])
    if membership.save
      flash[:notice] = "グループに参加しました"
      redirect_to request.referer
    else
      flash[:alert] = "失敗"
      redirect_to request.referer
    end
  end

  def destroy
    membership = current_user.memberships.find_by(group_id: params[:group_id])
    membership.destroy
    flash[:notice] = "グループを退会しました"
    redirect_to request.referer
  end
end
