class FavoriteMoviesController < ApplicationController
  before_action :authenticate_user

  def index
    # Get the favorite movies for the current user
    @favorite_movies = current_user.favorite_movies.includes(:movie)
    render "favorite_movies/index" # Use JBuilder template for consistency
  end

  def create
    # Resolve the movie from either an existing movie_id (Watchlist flow) or the
    # raw TMDb data sent from the search page (find-or-create by imdb_id).
    movie = resolve_movie

    unless movie&.persisted?
      render json: { error: "Movie could not be found or created" }, status: :unprocessable_entity
      return
    end

    existing = FavoriteMovie.find_by(user_id: current_user.id, movie_id: movie.id)

    # Toggle: if already favorited, remove it (same pattern as Watchlist create)
    if existing
      existing.destroy
      render json: { message: "Removed from Favorites", in_favorites: false }
      return
    end

    # Watchlist and Favorites are mutually exclusive: drop it from the Watchlist if present.
    WatchlistMovie.where(user_id: current_user.id, movie_id: movie.id).destroy_all

    @favorite_movie = FavoriteMovie.create(user_id: current_user.id, movie_id: movie.id)

    if @favorite_movie.persisted?
      render "favorite_movies/show"  # includes in_favorites: true
    else
      render json: { errors: @favorite_movie.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite_movie = FavoriteMovie.find_by(id: params[:id], user_id: current_user.id)
    if @favorite_movie
      # Remove from Favorites only. We no longer auto-add back to the Watchlist,
      # since movies can now be favorited directly (and may never have been on it).
      @favorite_movie.destroy

      render json: { message: "Favorite Movie removed" }
    else
      render json: { error: "Favorite Movie not found" }, status: :not_found
    end
  end

  private

  def resolve_movie
    if params[:movie_id].present?
      Movie.find_by(id: params[:movie_id])
    elsif params[:imdb_id].present?
      # Look up by imdb_id only (same approach as the Watchlist controller)
      Movie.find_by(imdb_id: params[:imdb_id]) || Movie.create(
        title: params[:title],
        image_url: params[:image_url],
        description: params[:description],
        director: params[:director],
        release_year: params[:release_year],
        imdb_id: params[:imdb_id],
        streaming_services: params[:streaming_services] || []
      )
    end
  end
end
