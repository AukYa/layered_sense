class AnswersController < ApplicationController
  before_action :set_question, only: [:create, :destroy]

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
    @question_answers = @question.answers
    Answer.find_by(id: params[:id], question_id: params[:question_id]).destroy
    flash[:notice] = "削除しました"
    redirect_to request.referer
  end
  
  def best
    @answer = Answer.find(params[:answer_id])
    question = Question.find(params[:question_id])
    if  question.answers.find_by(is_best_answer: true)
      question.answers.find_by(is_best_answer: true).update(is_best_answer: false)
    end
    @answer.update(is_best_answer: true)
    redirect_to request.referer
  end
  
  # def best_off
  #   @answer = Answer.find(params[:answer_id])
  #   @answer.update(is_best_answer: false)
  #   redirect_to request.referer
  # end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:content, :attachments_file)
  end
end
