class FavoritesController < ApplicationController
  def create
    work = Work.find(params[:work_id])
    @favorite = current_user.favorites.new(work_id: work.id)
    @favorite.save
  end

  def destroy
  end
end