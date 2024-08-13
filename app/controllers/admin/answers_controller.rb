class Admin::AnswersController < ApplicationController
  before_action :authenticate_admin!

  layout 'admin'

  def destroy
    @question_answers = @answers
    Answer.find_by(id: params[:id], question_id: params[:question_id]).destroy
    flash[:notice] = "削除しました"
    redirect_to request.referer
  end
end
