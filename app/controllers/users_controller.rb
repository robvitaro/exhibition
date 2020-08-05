class UsersController < ApplicationController
  def index
    @users = User.confirmed.galleried
  end

  def show
    @user = User.find(params[:id])
  end
end
