class WorksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user
  before_action :confirm_owner, except: [:index, :show]

  helper_method :user_is_owner?

  def index
    @works = @user.works
  end

  def new
    @work = @user.works.new
  end

  def create
    @work = @user.works.new(work_params)
    if @work.save
      redirect_to user_work_path(@user, @work), notice: 'Work created'
    else
      render :new
    end
  end

  def show
    @work = @user.works.find(params[:id])
  end

  def edit
    @work = @user.works.find(params[:id])
  end

  def update
    @work = @user.works.find(params[:id])
    if @work.update(work_params)
      redirect_to user_work_path(@user, @work), notice: 'Work updated'
    else
      render :edit
    end
  end

  def destroy
    @work = @user.works.find(params[:id])
    @work.destroy
    redirect_to user_works_path(@user)
  end

  private

  def work_params
    params.require(:work).permit(:name, :description, images: [])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def user_is_owner?
    current_user == @user
  end

  def confirm_owner
    render json: {}, status: :unauthorized unless user_is_owner?
  end
end
