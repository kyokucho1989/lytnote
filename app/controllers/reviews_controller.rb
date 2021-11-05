class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def index
    @reviews = Review.where(user_id: current_user.id).page(params[:page])
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

  def get_genre_nameset
    genres = Genre.where(user_id: current_user.id)
    genres.pluck(:id, :name)
  end

  def get_genre_name(id)
    @genres = Genre.where(user_id: current_user.id)
    @genres.where(id: id).first[:name]
  end
  helper_method :get_genre_name

  def create
    review = Review.new(review_params)
    review.user_id = current_user.id
    review.save!

    param_plans = params.require(:review)[:plans]
    plan_keys = param_plans.keys
    item = param_plans.values

    before_plan_state = Plan.find(plan_keys)
    plan_keys.each_with_index do |id, i|
      Plan.find(id).update!(item[i])
      review.review_items.create!(plan_id: id)
    end
    after_plan_state = Plan.find(plan_keys)

    genres_set = get_genre_nameset
    share_content = Review.convert_content_shared(before_plan_state, after_plan_state, review_params, genres_set)

    review.content_for_share = share_content
    review.save!
  end

  def select_plan
    @plans = Plan.where(user_id: current_user.id)
  end

  def re_select_plan
    @plans = Plan.where(user_id: current_user.id)
    review_item = ReviewItem.where(review_id: params[:id])
    @selected_plan_ids = review_item.pluck(:plan_id).to_a
  end

  def edit
    @review = Review.find(params[:id])
    @review_item_array = ReviewItem.where(review_id: @review.id).to_a
    @plans = Plan.where(id: @review_item_array.pluck(:plan_id))
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    plan_params = params[:review].permit(plans: {}).values.first
    selected_plan_ids = plan_params.keys
    before_plan_state = Plan.find(selected_plan_ids)
    selected_plan_ids.each do |plan_id|
      update_plan_params = plan_params[plan_id]
      plan = Plan.find(plan_id)
      plan.update!(update_plan_params)
    end
    after_plan_state = Plan.find(selected_plan_ids)
    genres_set = get_genre_nameset
    share_content = Review.convert_content_shared(before_plan_state, after_plan_state, review_params, genres_set)
    review.content_for_share = share_content
    review.save!
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
