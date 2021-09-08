class PlansController < ApplicationController
  def index
    @plans = Plan.all
  end
  def new
    @plan = Plan.new
  end

  def create
    binding.pry
    plan = Plan.new(plan_params)
    plan.user_id = current_user.id
    plan.save!
    # Plan.create(plan_params)
  end

  private
  def plan_params
    params.require(:plan).permit(:name, :genre_id)
  end
end
