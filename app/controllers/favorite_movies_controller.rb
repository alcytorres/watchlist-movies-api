class FavoriteMoviesController < ApplicationController
  # before_action :authenticate_user!

  def index
    # Get the favorite movies for the current user
    @favorite_movies = current_user.favorite_movies.includes(:movie)
    render "favorite_movies/index" # NEW: Use JBuilder template for consistency
  end

  def create
    # NEW: Check if the movie is in the user's Watchlist
    @watchlist_movie = WatchlistMovie.find_by(user_id: current_user.id, movie_id: params[:movie_id])
    if @watchlist_movie
      # NEW: Remove from Watchlist
      @watchlist_movie.destroy

      # Add to Favorites
      @favorite_movie = FavoriteMovie.create(
        user_id: current_user.id,
        movie_id: params[:movie_id],
      )

      if @favorite_movie.persisted?
        render "favorite_movies/show"  # NEW: Use JBuilder template
      else
        render json: { errors: @favorite_movie.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Movie must be in Watchlist before adding to Favorites" }, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite_movie = FavoriteMovie.find_by(id: params[:id], user_id: current_user.id)
    if @favorite_movie
      # NEW: Get the movie ID before destroying
      movie_id = @favorite_movie.movie_id

      # Remove from Favorites
      @favorite_movie.destroy

      # NEW: Add back to Watchlist
      @watchlist_movie = WatchlistMovie.create(
        user_id: current_user.id,
        movie_id: movie_id,
      )

      render json: { message: "Favorite Movie removed and added back to Watchlist" }
    else
      render json: { error: "Favorite Movie not found" }, status: :not_found
    end
  end
end
