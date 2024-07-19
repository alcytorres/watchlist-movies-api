class FavoriteMoviesController < ApplicationController


  def index
    @favorite_movies = FavoriteMovie.all
    render :index
  end

  def create
    @favorite_movie = FavoriteMovie.create(
      user_id: current_user.id,
      movie_id: params[:movie_id],
    )
    render :show
  end

  def destroy
    @favorite_movie = FavoriteMovie.find_by(id: params[:id])
    if @favorite_movie
      @favorite_movie.destroy
      render json: { message: "Favorite Movie destroyed successfully" }
    else
      render json: { error: "Favorite Movie not found" }, status: :not_found
    end
  end

  # def destroy
  #   @favorite_movie = FavoriteMovie.find_by(id: params[:id])
  #   @favorite_movie.destroy
  #   render json: { message: "Favorite Movie destroyed successfully" }
  # end


end
