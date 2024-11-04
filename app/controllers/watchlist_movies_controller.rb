class WatchlistMoviesController < ApplicationController
  # before_action :authenticate_user

  # Skip CSRF verification for API requests
  skip_before_action :verify_authenticity_token

  def index
    # Get the watchlist movies for the current user
    @movies = current_user.movies_in_watchlist
    render "movies/index"  # Reuse movies/index.json.jbuilder
  end

  def create
    # Find or create the movie without including the streaming_services in the WHERE clause
    @movie = Movie.find_or_create_by(
      title: params[:title],
      image_url: params[:image_url],
      description: params[:description],
      director: params[:director],
      release_year: params[:release_year],
      imdb_id: params[:imdb_id]
    ) do |movie|
      # Assign the streaming_services after finding or creating the movie
      movie.streaming_services = params[:streaming_services]
    end

    # Add movie to user's watchlist
    @watchlist_movie = WatchlistMovie.find_or_create_by(
      user_id: current_user.id,
      movie_id: @movie.id,
    )

    if @watchlist_movie.persisted?
      render "watchlist_movies/index", formats: :json
    else
      render json: { errors: @watchlist_movie.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    # Remove movie from user's watchlist
    @watchlist_movie = WatchlistMovie.find_by(user_id: current_user.id, movie_id: params[:id])
    if @watchlist_movie
      @watchlist_movie.destroy
      render json: { message: "Movie removed from your Watchlist" }
    else
      render json: { error: "Movie not found in your Watchlist" }, status: :not_found
    end
  end
end
