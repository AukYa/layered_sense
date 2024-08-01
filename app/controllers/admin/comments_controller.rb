class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  layout 'admin'

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(admin_comment_params)
      flash[:notice] = "コメントを編集しました"
      redirect_to admin_work_path(@comment.work)
    else
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
  end

  def destroy
    @work = Work.find(params[:work_id])
    @work_comments = @work.comments
    Comment.find_by(id: params[:id], work_id: params[:work_id]).destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to request.referer
  end

  private

  def admin_comment_params
    params.require(:comment).permit(:content)
  end
end
