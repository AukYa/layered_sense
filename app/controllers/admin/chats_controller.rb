class Admin::ChatsController < ApplicationController
  before_action :authenticate_admin!

  layout 'admin'

  def destroy
    @group = Group.find(params[:group_id])
    @group_chats = @group.chats
    Chat.find_by(id: params[:id], group_id: params[:group_id]).destroy
    flash[:notice] = "削除しました"
    redirect_to request.referer
  end
end
