class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    membership = current_user.memberships.new(group_id: params[:group_id])
    membership.save
    render 'replace_btn'
  end

  def destroy
    membership = current_user.memberships.find_by(group_id: params[:group_id])
    membership.destroy
    render 'replace_btn'
  end
end
