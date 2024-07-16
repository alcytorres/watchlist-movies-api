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

  def destroy
    @favorite_movie = FavoriteMovie.find_by(id: params[:id])
    @favorite_movie.destroy
    render json: { message: "Favorite Movie destroyed successfully" }
  end


end
