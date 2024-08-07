class GroupsController < ApplicationController
  def index
    @groups = Group.page(params[:page]).order(created_at: :desc)
  end

  def edit
  end

  def update
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
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
    @works = @group.works.page(params[:page]).order(created_at: :desc)
    @chat = Chat.new
    @chats = @group.chats
    @work = Work.new
  end

  def destroy
  end

  private

  def group_params
    params.require(:group).permit(:title, :introduction, :music_file, :group_image, :owner_id)
  end
end
