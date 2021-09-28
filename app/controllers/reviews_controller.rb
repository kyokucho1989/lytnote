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
    binding.pry
  end

  def edit; end

  def destroy; end

  def update; end
end
