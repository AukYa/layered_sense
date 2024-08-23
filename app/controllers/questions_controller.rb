class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

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
    is_matching_login_user
  end

  def update
    is_matching_login_user
    if @question.update(question_params)
      flash[:notice] = '質問を編集しました'
      redirect_to question_path(@question)
    else
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
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
    @question.destroy
    flash[:notice] = "質問を削除しました"
    redirect_to questions_path
  end

  def my_questions
    @my_questions = Question.where(user_id: current_user.id)
  end

  private

  def is_matching_login_user
    unless @question.user_id == current_user.id
      flash[:alert] = "利用できません"
      redirect_to homes_top_path
    end
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, :attachments_file)
  end
end
