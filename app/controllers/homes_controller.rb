class HomesController < ApplicationController
  def top
    @works = Work.page(params[:page]).per(12).order(created_at: :desc)
  end

  def about
  end
end
