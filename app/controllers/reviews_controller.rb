class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def index
    @reviews = Review.where(user_id: current_user.id)
  end

  def show; end

  def new
    @review = Review.new
    @plans = Plan.where(user_id: current_user.id)
    @plans.each {|pl| pl.review_items.build }
    binding.pry
  end

  def create
    #まずはReview.newをする。
    review = Review.new(review_params)
    review.user_id = current_user.id
    review.save!
    binding.pry
    #つぎにPlanに対応したreviw_itemsを保存していく
    param_plans = params.require(:review)[:plans]
    plan_keys = param_plans.keys
    item = param_plans.values
    plan_keys.each_with_index do |id,i|
      review_item_attribute = item[i].values.first["0"]
      review_item_attribute[:review_id] = review.id
      Plan.find(id).review_items.update(review_item_attribute)
    end
  end
  
  def select_plan
    @plans = Plan.where(user_id: current_user.id)
  end
  def edit; end

  def destroy; end

  def update; end

  private

  def review_params
    # params.require(:review).permit(:content, :reviewed_on, review_items_attributes: [:copied_plan_name, :copied_plan_deadline, :copied_plan_status, :deadline_after_review, :status_after_review])
    params.require(:review).permit(:content,:reviewed_on)
  end
  def add_plan_params
    # params.require(:review).permit(:content, :reviewed_on, review_items_attributes: [:copied_plan_name, :copied_plan_deadline, :copied_plan_status, :deadline_after_review, :status_after_review])
    params.require(:review).permit(:content, plans: {})
  end
end
