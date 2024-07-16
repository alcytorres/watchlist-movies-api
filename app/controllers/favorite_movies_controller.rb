class FavoriteMoviesController < ApplicationController


  def index
    @favorite_movies = FavoriteMovie.all
    render :index
  end


  def create
    @favorite_movie = FavoriteMovie.create(
      user_id: params[:user_id],
      movie_id: params[:movie_id],
    )
    render :show
  end

end
