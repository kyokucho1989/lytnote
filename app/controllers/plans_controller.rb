class PlansController < ApplicationController
  before_action :authenticate_user!, except: :index
  include Component

  def index
    if user_signed_in?
      plans_nonorder = Plan.includes(:review_items).where(user_id: current_user.id).page(params[:page])
      @plans = plans_nonorder.order(deadline: :desc)
      @genres = Genre.includes(:plans).where(user_id: current_user.id)
      @select_genre = @genres
      @genre_name = Array.new(@genres.size, 0)
    else
      @plans = Plan.where(user_id: 0)
      @genres = Genre.where(user_id: 0)
    end
  end

  helper_method :get_genre_name

  def new
    @plan = Plan.new
    @genre = Genre.new
    @select_genre = Genre.where(user_id: current_user)
    @genres =  @select_genre
  end

  def create
    
    genre_name = params[:plan][:genreset]
    @genre_new = Genre.find_by(name:genre_name,user_id: current_user)
    if @genre_new.nil?
      @genre_new = Genre.new("name"=> genre_name, "user_id" => current_user.id)
      
    end
    @genre_new.save
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
    @plan.status = "進行中"
    @plan.genre_id = @genre_new.id
    if @plan.save
      flash[:notice] = "目標を投稿しました"
      redirect_to action: 'index'
    else
      flash.now[:alert] = "投稿に失敗しました"
      @select_genre = Genre.where(user_id: current_user)
      render :new
    end
  end

  def edit
    @plan = Plan.find(params[:id])
    @select_genre = Genre.where(user_id: current_user)
    
    @genres = Genre.includes(:user).where(user_id: current_user.id)
    if @plan.genre_id.nil?
      @genre = Genre.new
    else
      @genre = Genre.find(@plan.genre_id)
    end
   
  end

  def update
    @plan = Plan.find(params[:id])
    genre_name = params[:plan][:genreset]

    # ジャンル名前がブランクかどうか
      # ブランクじゃない 
        # Genrename検索
        # ジャンルがすでにあるか
          #　ジャンルがなければ新規作成
          # ジャンル名前についてバリデーション確認
           # エラーなら　エラー発生
        # すでにあればジャンルはそれ

      # ブランク
         # Genre id = nil

    # アップデート 

    if !genre_name.blank?

      @genre_new = Genre.find_by(name:genre_name,user_id: current_user)
      if @genre_new.nil?
        @genre_new = Genre.new("name"=> genre_name, "user_id" => current_user.id)    
      end


      if !@genre_new.save
        flash.now[:alert] = "修正に失敗しました"
        @select_genre = Genre.where(user_id: current_user)
        @genres = Genre.includes(:user).where(user_id: current_user.id)
        if @plan.genre_id.nil?
          @genre = Genre.new
        else
          @genre = Genre.find(@plan.genre_id)
        end
        render :edit
      end
    end
    if @plan.update(plan_params)
      if !@genre_new.nil?
        @plan.update({"genre_id" => @genre_new.id})
      end
      flash[:notice] = "目標を修正しました"
      redirect_to action: 'index'
    else
      flash.now[:alert] = "修正に失敗しました"
      @select_genre = Genre.where(user_id: current_user)    
      render :edit
    end

    
  end

  def destroy
    plan = Plan.find(params[:id])
    plan.destroy
    if plan.errors.any?
      flash[:notice] = plan.errors.full_messages.first
    else
      flash[:notice] = "目標を削除しました"
    end
    redirect_to action: 'index'
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :genre_id, :deadline, :status)
  end
end
