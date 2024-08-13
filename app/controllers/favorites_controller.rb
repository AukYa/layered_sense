class FavoritesController < ApplicationController
  def create
    work = Work.find(params[:work_id])
    @favorite = current_user.favorites.new(work_id: work.id)
    @favorite.save
    render 'replace_btn'
  end

  def destroy
    work = Work.find(params[:work_id])
    @favorite =  current_user.favorites.find_by(work_id: work.id)
    @favorite.destroy
    render 'replace_btn'
  end
  
  def index
    # @works = Work.where(user_id: current_user.id).favorite.present?
    @works = current_user.favorites.map(&:work)
    @works_page = Work.page(params[:page]).per(30).order(created_at: :desc)
  end
end
