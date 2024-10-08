class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @works_page = Work.page(params[:page]).per(30).order(created_at: :desc)
    @users_page = User.page(params[:page]).per(30).order(created_at: :desc)
    @groups_page = Group.page(params[:page]).per(20).order(created_at: :desc)
    @questions_page = Question.page(params[:page]).per(20).order(created_at: :desc)

    if params[:word].empty?
      flash[:alert] = "入力内容がありません"
      redirect_to request.referer
      return
    elsif @range == 'User'
      @users = User.looks(params[:search], params[:word])
    elsif @range == 'Work'
      @works = Work.looks(params[:search], params[:word])
    elsif @range == 'Group'
      @groups = Group.looks(params[:search], params[:word])
    elsif @range == 'Question'
      @questions = Question.looks(params[:search], params[:word])
    else
      @tags = Tag.looks(params[:search], params[:word])
    end
    render 'search_result'
  end
end
