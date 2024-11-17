class WatchlistMoviesController < ApplicationController
  # before_action :authenticate_user

  # Skip CSRF verification for API requests
  skip_before_action :verify_authenticity_token

  # Fetch both Watchlist and Favorites for the current user
  def user_collections
    @watchlist_movies = current_user.watchlist_movies.includes(:movie)
    @favorite_movies = current_user.favorite_movies.includes(:movie)

    render json: {
      watchlist: @watchlist_movies.map { |watchlist_movie| watchlist_movie.movie.imdb_id },
      favorites: @favorite_movies.map { |favorite_movie| favorite_movie.movie.imdb_id }
    }
  end


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

    # Check if the movie is already in Favorites for the user
    if FavoriteMovie.exists?(user_id: current_user.id, movie_id: @movie.id)
      render json: { error: "This movie is already in Favorites and cannot be added to the Watchlist.", in_watchlist: false }
      return
    end

    # Check if movie already exists in watchlist
    @watchlist_movie = WatchlistMovie.find_by(
      user_id: current_user.id,
      movie_id: @movie.id
    )

    if @watchlist_movie
      # REMOVE the movie from watchlist if it exists
      @watchlist_movie.destroy
      render json: { message: "Movie removed from your Watchlist", in_watchlist: false }
    else
      # ADD movie to watchlist if it does not exist
      @watchlist_movie = WatchlistMovie.create(user_id: current_user.id, movie_id: @movie.id)
      if @watchlist_movie.persisted?
        render "watchlist_movies/show", formats: :json, locals: { watchlist_movie: @watchlist_movie }
      else
        render json: { errors: @watchlist_movie.errors.full_messages }, status: :unprocessable_entity
      end
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
