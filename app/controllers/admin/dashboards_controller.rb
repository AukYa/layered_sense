class Admin::DashboardsController < ApplicationController
  before_action :authenticate_admin!
  
  layout 'admin'
  
  def index
    @users = User.all
  end
end
