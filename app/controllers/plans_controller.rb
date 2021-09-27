class PlansController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    if user_signed_in?
      @plans = Plan.where(user_id: current_user.id)
      @genres = Genre.where(user_id: current_user.id)
    else
      @plans = Plan.where(user_id: 0)
      @genres = Genre.where(user_id: 0)
    end
  end

  def new
    @plan = Plan.new
    @select_genre = Genre.where(user_id: current_user)
  end

  def create
    binding.pry
    plan = Plan.new(plan_params)
    plan.user_id = current_user.id
    plan.save!
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :genre_id, :deadline, :status)
  end
end
