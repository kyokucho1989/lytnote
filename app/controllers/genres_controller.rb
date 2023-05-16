class GenresController < ApplicationController
  before_action :authenticate_user!

  def index
    @genres = Genre.where(user_id: current_user.id)
  end

  def new
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
    redirect_to action: 'index' unless @genre.user_id == current_user.id
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンルを修正しました"
      redirect_to action: 'index'
    else
      flash.now[:alert] = "追加に失敗しました"
      render :edit
    end
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.user_id = current_user.id
    if @genre.save
      flash[:notice] = "ジャンルを追加しました"
      redirect_to action: 'index'
    else
      flash.now[:alert] = "追加に失敗しました"
      render :new
    end
  end

  def destroy
    genre = Genre.find(params[:id])

    flash[:notice] = if genre.destroy
                       "ジャンルを削除しました"
                     else
                       genre.errors.full_messages.first
                     end
    redirect_to action: 'index'
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
