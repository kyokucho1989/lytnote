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
  end

  def create

    review = Review.new(review_params)
    review.user_id = current_user.id
    review.save!
    binding.pry
  end

  def edit; end

  def destroy; end

  def update; end

  private

  def review_params
    params.require(:review).permit(:content, :reviewed_on, review_items_attributes: [:copied_plan_name, :copied_plan_deadline, :copied_plan_status, :deadline_after_review, :status_after_review])
  end
end
