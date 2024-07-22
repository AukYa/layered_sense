class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @range = params[:range]
    
    if @range == 'User'
      @users = User.looks(params[:search], params[:word])
    else
      @works = Work.looks(params[:serach], params[:word])
    end
  end
end
