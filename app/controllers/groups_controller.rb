class GroupsController < ApplicationController
  def index
  end

  def edit
  end
  
  def update
  end

  def new
    @group = Group.new
  end
  
  def create
  end

  def show
  end
  
  def destroy
  end
  
  private
  
  def group_params
    params.require(:group).permit(:title, :introduction, :music_file)
  end
end
