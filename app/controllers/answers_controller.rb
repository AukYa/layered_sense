class AnswersController < ApplicationController
  before_action :set_question, only: [:edit, :update, :create, :destroy]

  def edit
  end

  def update
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id
    @answer.question_id = @question.id
    if @answer.save
      flash[:notice] = '回答を作成しました'
      redirect_to request.referer
    else
      flash[:alert] = '回答の作成に失敗しました'
      redirect_to request.referer
    end
  end

  def destroy
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:content, :attachments_file)
  end
end
