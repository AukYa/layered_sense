class WorksController < ApplicationController
  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    @work.user_id = current_user.id
    if @work.save
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  def index
    @works = Work.all
  end

  def show
    @work = Work.find(params[:id])
  end

  def edit
  end
  
  def destroy
    @work = Work.find(params[:id])
    @work.destroy
    redirect_to works_path
  end

  private

  def work_params
    params.require(:work).permit(:name, :introduction, :audio, :music_file, :title)
  end
end
