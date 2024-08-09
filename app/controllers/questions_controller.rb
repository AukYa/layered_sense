class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  
  def index
    @questions = Question.page(params[:page]).order(created_at: :desc)
  end

  def show
    @answer = Answer.new
    @answers = @question.answers
  end

  def edit
  end
  
  def update
  end

  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      flash[:notice] = '質問を作成しました'
      redirect_to questions_path
    else
      flash.now[:alert] = '質問の作成に失敗しました'
      render :new
    end
  end
  
  def destroy
  end
  
  private
  
  def best
    @answer = Answer.find(params[:answer_id])
    @answer.update(is_best_answer: true)
    redirect_to request.referer
  end

  # def best_off
  #   @answer = Answer.find(params[:answer_id])
  #   @answer.update(is_best_answer: false)
  #   redirect_to request.referer
  # end
  
  def set_question
    @question = Question.find(params[:id])
  end
  
  def question_params
    params.require(:question).permit(:title, :content, :attachments_file)
  end
end
