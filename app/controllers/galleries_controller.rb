class GalleriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user
  before_action :confirm_owner, except: [:index, :show]

  helper_method :user_is_owner?

  def index
    @galleries = @user.galleries
  end

  def new
    @gallery = @user.galleries.new
  end

  def create
    @gallery = @user.galleries.new(gallery_params)
    if @gallery.save
      redirect_to user_gallery_path(@user, @gallery), notice: 'Gallery created'
    else
      render :new
    end
  end

  def show
    @gallery = @user.galleries.find(params[:id])
  end

  def edit
    @gallery = @user.galleries.find(params[:id])
  end

  def update
    @gallery = @user.galleries.find(params[:id])
    if @gallery.update(gallery_params)
      redirect_to user_gallery_path(@user, @gallery), notice: 'Gallery updated'
    else
      render :edit
    end
  end

  def destroy
    @gallery = @user.galleries.find(params[:id])
    @gallery.destroy
    redirect_to user_galleries_path(@user)
  end

  private

  def gallery_params
    params.require(:gallery).permit(:name, :description)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def user_is_owner?
    current_user == @user
  end

  def confirm_owner
    render json: {}, status: :unauthorized unless current_user == @user
  end
end
