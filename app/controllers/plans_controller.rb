class PlansController < ApplicationController
  def index
    @plans = Plan.all
    @genres = Genre.all
  end
  def new
    @plan = Plan.new

    # binding.pry
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
