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
    # まずはReview.newをする。
    review = Review.new(review_params)
    review.user_id = current_user.id
    review.save!

    # 変更前の計画の状態を保存しておく


    # つぎにPlanに対応したreviw_itemsを保存していく
    param_plans = params.require(:review)[:plans]
    plan_keys = param_plans.keys
    item = param_plans.values
    before_plan_state = Plan.find(plan_keys)
    plan_keys.each_with_index do |id, i|
      binding.pry
      Plan.find(id).update!(item[i])
      review.review_items.create!(plan_id: id)
    end
    after_plan_state = Plan.find(plan_keys)

    # 文章の例

    # 2021/10/2
    # 目標1:【英語】 TOEIC参考書20P 期日10/1　→ 完了
    # 目標2:【Ruby】 チェリー本2章 期日9/28　→ 未完了　期日 10/4に延長
    # 目標3:【Python】 環境構築 期日9/25　→ 中止　
    # 振り返り：
    # いろいろできた。
    binding.pry
    genres_set = get_genre_nameset
    share_content = Review.convert_content_shared(before_plan_state,after_plan_state,review_params, genres_set)

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
    selected_plan_ids.each do |plan_id|
      update_plan_params = plan_params[plan_id]
      plan = Plan.find(plan_id)
      plan.update!(update_plan_params)
    end
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
