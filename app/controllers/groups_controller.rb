class GroupsController < ApplicationController
  def index
    @groups = Group.page(params[:page]).per(20).order(created_at: :desc)
  end

  def edit
    @group = Group.find(params[:id])
    unless @group.is_owned_by?(current_user)
      flash[:alert] = '利用できません'
      redirect_to homes_top_path
    end
  end

  def update
    @group = Group.find(params[:id])
    unless @group.is_owned_by?(current_user)
      flash[:alert] = '利用できません'
      redirect_to homes_top_path
    end
    if @group.update(group_params)
      flash[:notice] = 'グループを編集しました'
      redirect_to group_path(@group)
    else
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.memberships.build(user_id: current_user.id)
    if @group.save
      flash[:notice] = "グループを作成しました"
      redirect_to groups_path
    else
      flash.now[:alert] = "グループの作成に失敗しました"
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @works = @group.works.page(params[:page]).per(30).order(created_at: :desc)
    @chat = Chat.new
    @chats = @group.chats.page(params[:page]).per(30).order(created_at: :desc)
    @work = @group.works.build
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    flash[:notice] = "グループを削除しました"
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:title, :introduction, :music_file, :group_image, :owner_id)
  end
end
