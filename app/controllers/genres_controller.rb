class GenresController < ApplicationController
  before_action :authenticate_user!

  def index
    @genres = Genre.where(user_id: current_user.id)
  end

  def new
    @genre = Genre.new
  end

  def create
    genre = Genre.new(genre_params)
    genre.user_id = current_user.id
    genre.save!
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
  end


  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
