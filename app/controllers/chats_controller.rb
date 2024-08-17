class ChatsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @chat = Chat.new(chat_params)
    @chat.group_id = @group.id
    @chat.user_id = current_user.id
    if @chat.save
      redirect_to request.referer
    else
      flash[:alert] = "チャット内容を入力してください"
      redirect_to request.referer
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @group_chats = @group.chats
    Chat.find_by(id: params[:id], group_id: params[:group_id]).destroy
    flash[:notice] = "削除しました"
    redirect_to request.referer
  end

  private

  def chat_params
    params.require(:chat).permit(:chat)
  end
end
