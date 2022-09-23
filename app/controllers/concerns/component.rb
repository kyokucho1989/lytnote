module Component
  def get_genre_name(id)
    if id.nil? || id == 0
      ""
    else
      genre = @select_genre.find{|array| array[:id] == id }
      genre.name 
    end   
  end

  def get_genre_nameset
    genres = Genre.where(user_id: current_user.id)
    genres.pluck(:id, :name)
  end
end