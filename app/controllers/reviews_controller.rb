class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show; end

  def new
    @review = Review.new
    @plans = Plan.all
    binding.pry
  end

  def create
    binding.pry
  end

  def edit; end

  def destroy

  end

  def update; end
end
