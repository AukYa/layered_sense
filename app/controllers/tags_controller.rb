class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    #検索されたタグに紐づく投稿を表示
    @works = @tag.works.page(params[:page]).per(30).order(created_at: :desc)
  end
  
  private
  
  def tag_params
    params.require(:tag).permit(:tag_name)
  end
end
