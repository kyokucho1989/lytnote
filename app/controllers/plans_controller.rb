class PlansController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    if user_signed_in?
      @plans = Plan.includes(:user).where(user_id: current_user.id).page(params[:page])
      @genres = Genre.includes(:user).where(user_id: current_user.id)
      @genre_name = Array.new(@genres.size, 0)
    else
      @plans = Plan.where(user_id: 0)
      @genres = Genre.where(user_id: 0)
    end
  end

  def get_genre_name(id)
    if id.nil?
      " "
    else
      genre = @genres.find{|array| array[:id] == id }
      genre.name 
    end   
  end

  helper_method :get_genre_name

  def new
    @plan = Plan.new
    @genre = Genre.new
    @select_genre = Genre.where(user_id: current_user)
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
    @genre = Genre.find(@plan.genre_id)
  end

  def update
    @plan = Plan.find(params[:id])

    genre_name = params[:plan][:genreset]
    @genre_new = Genre.find_by(name:genre_name,user_id: current_user)
    if @genre_new.nil?
      @genre_new = Genre.new("name"=> genre_name, "user_id" => current_user.id)
      
    end

    if !@genre_new.save
      flash.now[:alert] = "修正に失敗しました"
      @select_genre = Genre.where(user_id: current_user)
      @genres = Genre.includes(:user).where(user_id: current_user.id)
      @genre = Genre.find(@plan.genre_id)
      binding.pry
      render :edit
    else
      if @plan.update(plan_params)
        @plan.update({"genre_id" => @genre_new.id})
        flash[:notice] = "目標を修正しました"
        redirect_to action: 'index'
      else
        flash.now[:alert] = "修正に失敗しました"
        @select_genre = Genre.where(user_id: current_user)
        render :edit
      end
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
