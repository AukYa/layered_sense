class WorksController < ApplicationController
  before_action :restrict_guest_user_from_new, only: [:new]

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    @work.user_id = current_user.id
    tag_list = params[:work][:tag_name].split(',')
    revised_tags = Tag.revise_tags(tag_list).uniq
    if @work.save
      @work.save_tags(revised_tags)
      flash[:notice] = '投稿しました'
      if @work.group_id.nil?
        redirect_to user_path(current_user.id)
      else
        redirect_to group_path(@work.group_id)
      end
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

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
    is_matching_login_user
    @work = Work.find(params[:id])
  end

  def update
    is_matching_login_user
    @work = Work.find(params[:id])
    tag_list = params[:work][:tag_name].split(',')
    if @work.update(work_params)
      @work.save_tags(tag_list)
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

  def is_matching_login_user
    @work = Work.find(params[:id])
    unless @work.user_id == current_user.id
      flash[:alert] = "利用できません"
      redirect_to homes_top_path
    end
  end

  def work_params
    params.require(:work).permit(:name, :introduction, :music_file, :title, :group_id)
  end
end
