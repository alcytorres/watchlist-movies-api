class MoviesController < ApplicationController
  require 'net/http'

  # Skip CSRF verification for API requests
  skip_before_action :verify_authenticity_token

  def index
    p "current_user"
    p current_user
    p "current_user"

    # Exclude movies that the current user has already favorited
    @movies = Movie.where.not(id: current_user.favorite_movies.select(:movie_id))

    render :index
  end

  def user_movies
    @movies = current_user.movies
    render :index
  end

  def show
    @movie = Movie.find_by(id: params[:id])
    render :show
  end

  def create
    @movie = Movie.create(
      title: params[:title],
      image_url: params[:image_url],
      description: params[:description],
      director: params[:director],
      release_year: params[:release_year],
      imdb_id: params[:imdb_id],
      streaming_services: params[:streaming_services] # Include streaming_services
    )
    render :show
  end


  # The destroy action in this controller would typically be used to remove a movie from the entire database, not just from a user's watchlist. That is why there is no destroy action.



  # Search for movies by title using only TMDb API
  def search_tmdb
    tmdb_api_key = ENV['TMDB_API_KEY']
    puts "TMDb API Key: #{tmdb_api_key}"

    query = params[:query]

    url = URI("https://api.themoviedb.org/3/search/movie?api_key=#{tmdb_api_key}&query=#{URI.encode_www_form_component(query)}")
    response = Net::HTTP.get(url)
    tmdb_results = JSON.parse(response)
    puts response

    if tmdb_results["results"] && tmdb_results["results"].any?
      # Initialize an array to hold movie data
      movies = []

      # Mapping between TMDb provider IDs and your frontend IDs
      streaming_service_mapping = {
        # TMDb provider IDs mapped to your app's IDs
        "8" => "netflix",
        "9" => "amazon",
        "337" => "disney",
        "350" => "apple",
        "1899" => "max",      # For HBO Max
        "15" => "hulu",
        "531" => "paramount",
        # Add other mappings as needed
      }

      # Iterate over each movie result
      tmdb_results["results"].each do |movie|
        movie_id = movie["id"]

        # Fetch movie details including external IDs and credits
        movie_details_url = URI("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{tmdb_api_key}&append_to_response=credits,external_ids")
        movie_details_response = Net::HTTP.get(movie_details_url)
        movie_details = JSON.parse(movie_details_response)

        # Handle potential missing fields safely
        movie_title = movie_details["title"] || "Unknown Title"
        movie_description = movie_details["overview"] || "No description available"
        movie_release_date = movie_details["release_date"] ? movie_details["release_date"].split("-")[0] : "Unknown Year"
        movie_director = movie_details.dig("credits", "crew")&.find { |person| person["job"] == "Director" }&.[]("name") || "Unknown Director"
        movie_poster_path = movie_details["poster_path"] ? "https://image.tmdb.org/t/p/w500#{movie_details["poster_path"]}" : nil

        # Get imdb_id from 'external_ids'
        imdb_id = movie_details.dig("external_ids", "imdb_id")
        puts "IMDB ID: #{imdb_id}"

        # Fetch watch providers using TMDb API
        watch_providers_url = URI("https://api.themoviedb.org/3/movie/#{movie_id}/watch/providers?api_key=#{tmdb_api_key}")
        watch_providers_response = Net::HTTP.get(watch_providers_url)
        watch_providers = JSON.parse(watch_providers_response)

        # Extract US streaming services
        us_providers = watch_providers.dig("results", "US", "flatrate") || []
        normalized_sources = us_providers.map do |provider|
          streaming_service_mapping[provider["provider_id"].to_s] || "other"
        end

        # Build movie data hash without saving to the database
        movie_data = {
          tmdb_id: movie_id,
          imdb_id: imdb_id,
          title: movie_title,
          description: movie_description,
          release_year: movie_release_date,
          director: movie_director,
          image_url: movie_poster_path,
          streaming_services: normalized_sources.uniq # Use normalized_sources
        }

        # Add movie_data to movies array
        movies << movie_data
      end

      # Render JSON with array of movies
      render json: { movies: movies }
    else
      render json: { error: "Movie not found or no results available" }, status: :not_found
    end
  end

end