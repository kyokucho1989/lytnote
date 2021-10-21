class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def index
    @reviews = Review.where(user_id: current_user.id)
  end

  def show
    @review = Review.find(params[:id])
    @review_item_array = ReviewItem.where(review_id: @review.id).to_a
    @plans = Plan.where(id: @review_item_array.pluck(:plan_id))
  end

  def new
    @review = Review.new
    selected_plan_ids = select_plan_params[:checked_plan].map(&:to_i)
    @plans = Plan.where(id: selected_plan_ids)
    @review_item_array = Array.new(@plans.size, ReviewItem.new)
  end

  def get_genre_name(id)
    @genres = Genre.where(user_id: current_user.id)
    @genres.where(id: id).first[:name]
  end
  helper_method :get_genre_name

  def create
    # まずはReview.newをする。
    review = Review.new(review_params)
    review.user_id = current_user.id
    review.save!
    
    # つぎにPlanに対応したreviw_itemsを保存していく
    param_plans = params.require(:review)[:plans]
    plan_keys = param_plans.keys
    item = param_plans.values
    plan_keys.each_with_index do |id, i|
      Plan.find(id).update!(item[i])
      review.review_items.create!(plan_id:id)
    end
  end

  def select_plan
    @plans = Plan.where(user_id: current_user.id)
  end

  def edit
    @review = Review.find(params[:id])
    @review_item_array = ReviewItem.where(review_id: @review.id).to_a
    @plans = Plan.where(id: @review_item_array.pluck(:plan_id))
  end

  def update
    # binding.pry
    review = Review.find(params[:id])
    review.update(review_params)
    # review_item_ids = ReviewItem.where(review_id:params[:id]).ids
    review_item_params = params[:review].permit(plans: {}).values.first
    # review_item_array.each do |item|

    # selected_plan_id = item.keys.first
    selected_plan_ids = review_item_params.keys
    selected_plan_ids.each do |plan_id|
      update_review_item = review_item_params[plan_id]
    end
      update_review_item_content = item.values.first.values.first
      binding.pry
      review_item = ReviewItem.where(review_id: params[:id], plan_id: selected_plan_id).first
      review_item.update(update_review_item_content)
    # end

  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
  end

  private

  def review_params
    # params.require(:review).permit(:content, :reviewed_on, review_items_attributes: [:copied_plan_name, :copied_plan_deadline, :copied_plan_status, :deadline_after_review, :status_after_review])
    params.require(:review).permit(:content, :reviewed_on)
  end

  def add_plan_params
    params.require(:review).permit(plans: {})[:plans]
  end

  def select_plan_params
    params.permit(checked_plan: [])
  end

  def review_update_params
    params.require(:review).permit(:content, :reviewed_on, plans: {}, review_items_attributes: [:deadline_after_review, :status_after_review, :id])
  end
end
