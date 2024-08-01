class WorksController < ApplicationController
  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    @work.user_id = current_user.id
    tag_list = params[:work][:tag_name].split(',')
    if @work.save
      @work.save_tags(tag_list)
      flash[:notice] = '投稿しました'
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def index
    @works = Work.page(params[:page]).order(created_at: :desc)
    @users = User.all
  end

  def show
    @work = Work.find(params[:id])
    @comment = Comment.new
    @comments = @work.comments
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    if @work.update(work_params)
      flash[:notice] = '投稿を編集しました'
      redirect_to work_path(@work)
    else
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
  end

  def destroy
    work = Work.find(params[:id])
    work.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to works_path
  end

  private

  def work_params
    params.require(:work).permit(:name, :introduction, :music_file, :title)
  end
end
