class CommentsController < ApplicationController
  def create
    @work = Work.find(params[:work_id])
    @comment = Comment.new(comment_params)
    @comment.work_id = @work.id
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to request.referer
    else
      flash[:alert] = "コメント内容を入力してください"
      redirect_to request.referer
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

  def comment_params
    params.require(:comment).permit(:content)
  end
end
