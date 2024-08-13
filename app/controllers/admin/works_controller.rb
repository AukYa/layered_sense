class Admin::WorksController < ApplicationController
  before_action :authenticate_admin!

  layout 'admin'
  
  def index
    @works = Work.page(params[:page]).per(30).order(created_at: :desc)
    @users = User.all
  end

  def show
    @work = Work.find(params[:id])
    @comment = Comment.new
    @comments = @work.comments.page(params[:page]).per(30).order(created_at: :desc)
  end

  def edit
    @work = Work.find(params[:id])
  end
  
  def update
    @work = Work.find(params[:id])
    if @work.update(admin_work_params)
      flash[:notice] = '投稿を編集しました'
      redirect_to admin_work_path(@work)
    else
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
  end
  
  def destroy
    work = Work.find(params[:id])
    work.destroy
    redirect_to admin_works_path
    flash[:notice] = "投稿を削除しました"
  end

  private

  def admin_work_params
    params.require(:work).permit(:name, :introduction, :music_file, :title)
  end
  
  def admin_comment_params
    params.require(:comment).permit(:content)
  end
end
