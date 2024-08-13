class Admin::QuestionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  layout 'admin'
  
  def index
    @questions = Question.page(params[:page]).per(20).order(created_at: :desc)
    
  end

  def show
    @answers = @question.answers.page(params[:page]).per(10).order(created_at: :desc)
    @answer = Answer.new
    @best_answer = @answers.find_by(is_best_answer: true)
    @other_answers = @answers.where.not(id: @best_answer&.id) # ベストアンサー以外の回答を取得
  end

  def edit
  end
  
  def update
    if @question.update(admin_question_params)
      flash[:notice] = '質問を編集しました'
      redirect_to admin_question_path(@question)
    else
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
  end
  
  def destroy
    @question.destroy
    flash[:notice] = "質問を削除しました"
    redirect_to admin_questions_path
  end
  
  private
  
  def set_question
    @question = Question.find(params[:id])
  end
  
  def admin_question_params
    params.require(:question).permit(:title, :content, :attachments_file)
  end
end
