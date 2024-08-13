class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  layout 'admin'
  
  def index
    @groups = Group.page(params[:page]).per(20).order(created_at: :desc)
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(admin_group_params)
      flash[:notice] = 'グループを編集しました'
      redirect_to admin_group_path(@group)
    else
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
  end

  def show
    @group = Group.find(params[:id])
    @works = @group.works.page(params[:page]).per(30).order(created_at: :desc)
    @chats = @group.chats.page(params[:page]).per(30).order(created_at: :desc)
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    flash[:notice] = "グループを削除しました"
    redirect_to admin_groups_path
  end

  private

  def admin_group_params
    params.require(:group).permit(:title, :introduction, :music_file, :group_image, :owner_id)
  end
end
