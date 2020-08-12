class UsersController < ApplicationController
  before_action :set_user, except: [:index]

  helper_method :user_is_owner?

  def index
    @users = User.confirmed.galleried
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_is_owner?
    current_user == @user
  end
end
