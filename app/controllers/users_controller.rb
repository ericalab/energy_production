class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def import
    User.import(params[:fileupload][:file])
    redirect_to root_url
  end
end
