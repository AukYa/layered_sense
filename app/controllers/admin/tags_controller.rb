class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  layout 'admin'
  
  def index
    @tags = Tag.all
  end
  
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path
    flash[:notice] = "タグを削除しました"
  end
  
  private
  
  def admin_tag_params
    params.require(:tag).permit(:tag_name)
  end
end
