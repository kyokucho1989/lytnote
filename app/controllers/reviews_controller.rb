class ReviewsController < ApplicationController
  before_action :authenticate_user!
  include Component

  def index
    reviews_nonorder = Review.where(user_id: current_user.id).page(params[:page])
    @reviews =  reviews_nonorder.order(reviewed_on: :desc)
  end

  def show
    @select_genre = Genre.where(user_id: current_user)
    @review = Review.find(params[:id])
    @review_item_array = ReviewItem.where(review_id: @review.id).to_a
    @plans = Plan.where(id: @review_item_array.pluck(:plan_id))
  end

  def new
    @select_genre = Genre.where(user_id: current_user)
    @review = Review.new
    @plans = Plan.where(user_id: current_user.id, status: "進行中")
    @review_item_array = Array.new(@plans.size, ReviewItem.new)
    @plan = Plan.new
  end

  helper_method :get_genre_name

  def create
    @select_genre = Genre.where(user_id: current_user)
    @review = Review.new(review_params)
    @review.user_id = current_user.id

    param_plans = params.require(:review)[:plans]
    plan_keys = param_plans.keys
    item = param_plans.values

    if !@review.save
      flash.now[:alert] = "投稿に失敗しました"
      @plans = Plan.where(id: plan_keys)
      @plan = Plan.new
      @review_item_array = Array.new(@plans.size, ReviewItem.new)
      render :new
      return
    end

    before_plan_state = Plan.find(plan_keys)

    plan_keys.each_with_index do |id, i|
      @plan = Plan.find(id)
      if !@plan.update(item[i])
        flash.now[:alert] = "投稿に失敗しました"
        @plans = Plan.where(id: plan_keys)
        @review_item_array = Array.new(@plans.size, ReviewItem.new)
        render :new
        return
      end
      @review.review_items.create!(plan_id: id)
    end

    after_plan_state = Plan.find(plan_keys)

    genres_set = get_genre_nameset
    share_content = Review.convert_content_shared(before_plan_state, after_plan_state, review_params, genres_set)

    @review.content_for_share = share_content
    if @review.save
      flash[:notice] = "振り返りを投稿しました"
      redirect_to action: 'index'
    else
      flash.now[:alert] = "投稿に失敗しました"
      @plans = Plan.where(id: selected_plan_ids)
      @review_item_array = Array.new(@plans.size, ReviewItem.new)
      render :new
    end
  end

  def edit
    @select_genre = Genre.where(user_id: current_user)
    @review = Review.find(params[:id])
    @review_item_array = ReviewItem.where(review_id: @review.id).to_a
    @plans = Plan.where(id: @review_item_array.pluck(:plan_id))
    @plan = Plan.new
  end

  def update
    @review = Review.find(params[:id])
    if !@review.update(review_params)
      flash.now[:alert] = "投稿に失敗しました"
      @review_item_array = ReviewItem.where(review_id: @review.id).to_a
      @plans = Plan.where(id: @review_item_array.pluck(:plan_id))
      @plan = Plan.new
      render :edit
      return
    end

    plan_params = params[:review].permit(plans: {}).values.first
    selected_plan_ids = plan_params.keys
    before_plan_state = Plan.find(selected_plan_ids)
    selected_plan_ids.each do |plan_id|
      update_plan_params = plan_params[plan_id]
      @plan = Plan.find(plan_id)
      if !@plan.update(update_plan_params)
        flash.now[:alert] = "投稿に失敗しました"
        @review_item_array = ReviewItem.where(review_id: @review.id).to_a
        @plans = Plan.where(id: @review_item_array.pluck(:plan_id))
        render :edit
        return
      end
    end
    after_plan_state = Plan.find(selected_plan_ids)
    genres_set = get_genre_nameset
    share_content = Review.convert_content_shared(before_plan_state, after_plan_state, review_params, genres_set)
    @review.content_for_share = share_content
    if @review.save
      flash[:notice] = "振り返りを修正しました"
      redirect_to action: 'index'
    else
      flash.now[:alert] = "投稿に失敗しました"
      @plans = Plan.where(id: selected_plan_ids)
      @review_item_array = Array.new(@plans.size, ReviewItem.new)
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    if review.errors.any?
      flash[:notice] = review.errors.full_messages.first
    else
      flash[:notice] = "振り返りを削除しました"
    end
    redirect_to action: 'index'
  end

  def change_state
    @messages = params
    respond_to do |format| # リクエスト形式によって処理を切り分ける
      format.html { redirect_to :root } # html形式の場合
      format.json { render json: @messages } # json形式の場合
    end
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
