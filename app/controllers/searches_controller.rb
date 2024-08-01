class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @works_page = Work.page(params[:page]).order(created_at: :desc)
    @users_page = User.page(params[:page]).order(created_at: :desc)

    if @range == 'User'
      @users = User.looks(params[:search], params[:word])
    elsif @range == 'Work'
      @works = Work.looks(params[:search], params[:word])
    else
      @tags = Tag.looks(params[:search], params[:word])
    end

    render 'search_result'
  end
end
