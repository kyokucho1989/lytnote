class PlansController < ApplicationController
  before_action :authenticate_user!, except: :index 
  def index
    if user_signed_in?
      @plans = Plan.where(user_id: current_user.id).page(params[:page])
      @genres = Genre.where(user_id: current_user.id)
      @genre_name = Array.new(@genres.size, 0)
    else
      @plans = Plan.where(user_id: 0)
      @genres = Genre.where(user_id: 0)
    end
  end

  def get_genre_name(id)
    @genres = Genre.where(user_id: current_user.id)
    @genres.where(id: id).first[:name]
    # binding.pry
  end

  helper_method :get_genre_name

  def new
    @plan = Plan.new
    @select_genre = Genre.where(user_id: current_user)
  end

  def create
    plan = Plan.new(plan_params)
    plan.user_id = current_user.id
    plan.save!
  end

  def edit
    @plan = Plan.find(params[:id])
    @select_genre = Genre.where(user_id: current_user)
  end

  def update
    plan = Plan.find(params[:id])
    plan.update(plan_params)
  end

  def destroy
    plan = Plan.find(params[:id])
    plan.destroy
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :genre_id, :deadline, :status)
  end
end
