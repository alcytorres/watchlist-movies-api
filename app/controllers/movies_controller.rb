class MoviesController < ApplicationController
  require 'net/http'

  # NEW: Skip CSRF verification for API requests
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
      name: params[:name],
      image_url: params[:image_url],
      description: params[:description],
      director: params[:director],
      release_year: params[:release_year],
      imdb_id: params[:imdb_id], # NEW: Store imdb_id
    )
    render :show
  end

  # NEW: Search for movies by title in the TMDb API without saving to the database
  def search_tmdb
    tmdb_api_key = ENV['TMDB_API_KEY']
    puts "TMDb API Key: #{tmdb_api_key}"

    query = params[:query]

    url = URI("https://api.themoviedb.org/3/search/movie?api_key=#{tmdb_api_key}&query=#{URI.encode_www_form_component(query)}")
    response = Net::HTTP.get(url)
    tmdb_results = JSON.parse(response)
    puts response

    if tmdb_results["results"] && tmdb_results["results"].any?
      # NEW: Initialize an array to hold movie data
      movies = []

      # NEW: Iterate over each movie result
      tmdb_results["results"].each do |movie|
        movie_id = movie["id"]

        # Fetch movie details
        movie_details_url = URI("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{tmdb_api_key}&append_to_response=credits")
        movie_details_response = Net::HTTP.get(movie_details_url)
        movie_details = JSON.parse(movie_details_response)

        # Handle potential missing fields safely
        movie_title = movie_details["title"] || "Unknown Title"
        movie_description = movie_details["overview"] || "No description available"
        movie_release_date = movie_details["release_date"] ? movie_details["release_date"].split("-")[0] : "Unknown Year"
        movie_director = movie_details.dig("credits", "crew")&.find { |person| person["job"] == "Director" }&.[]("name") || "Unknown Director"
        movie_poster_path = movie_details["poster_path"] ? "https://image.tmdb.org/t/p/w500/#{movie_details["poster_path"]}" : nil

        # NEW: Get imdb_id safely
        imdb_id = movie_details["imdb_id"]
        puts "IMDB ID: #{imdb_id}"

        us_sources = []

        # NEW: Check if imdb_id is present
        if imdb_id.present?
          watchmode_api_key = ENV['WATCHMODE_API_KEY']

          # Search Watchmode for the movie to get the Watchmode title ID
          search_url = URI("https://api.watchmode.com/v1/search/?apiKey=#{watchmode_api_key}&search_field=imdb_id&search_value=#{imdb_id}")
          search_response = Net::HTTP.get(search_url)
          search_results = JSON.parse(search_response)

          if search_results["title_results"] && search_results["title_results"].any?
            watchmode_title_id = search_results["title_results"].first["id"]

            # Now fetch the streaming sources using the Watchmode title ID
            watchmode_sources_url = URI("https://api.watchmode.com/v1/title/#{watchmode_title_id}/sources/?apiKey=#{watchmode_api_key}")
            watchmode_sources_response = Net::HTTP.get(watchmode_sources_url)
            watchmode_results = JSON.parse(watchmode_sources_response)

            # Filter streaming availability for US region only
            us_sources = watchmode_results.select do |source|
              source["region"] == "US" && (source["type"] == "free" || source["type"] == "sub")
            end
          else
            puts "No Watchmode title found for IMDB ID #{imdb_id}"
          end
        else
          puts "IMDB ID is missing for movie #{movie_title}"
        end

        # NEW: Build movie data hash without saving to the database
        movie_data = {
          tmdb_id: movie_id,    # NEW: Use tmdb_id instead of id
          imdb_id: imdb_id,     # NEW: Include imdb_id
          name: movie_title,
          description: movie_description,
          release_year: movie_release_date,
          director: movie_director,
          image_url: movie_poster_path,
          streaming_sources: us_sources
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

  # NEW: Endpoint to get streaming sources for a movie by imdb_id
  def get_streaming_sources
    imdb_id = params[:imdb_id]

    if imdb_id.present?
      watchmode_api_key = ENV['WATCHMODE_API_KEY']

      # Search Watchmode for the movie to get the Watchmode title ID
      search_url = URI("https://api.watchmode.com/v1/search/?apiKey=#{watchmode_api_key}&search_field=imdb_id&search_value=#{imdb_id}")
      search_response = Net::HTTP.get(search_url)
      search_results = JSON.parse(search_response)

      if search_results["title_results"] && search_results["title_results"].any?
        watchmode_title_id = search_results["title_results"].first["id"]

        # Fetch the streaming sources using the Watchmode title ID
        watchmode_sources_url = URI("https://api.watchmode.com/v1/title/#{watchmode_title_id}/sources/?apiKey=#{watchmode_api_key}")
        watchmode_sources_response = Net::HTTP.get(watchmode_sources_url)
        watchmode_results = JSON.parse(watchmode_sources_response)

        # Filter streaming availability for US region only
        us_sources = watchmode_results.select do |source|
          source["region"] == "US" && (source["type"] == "free" || source["type"] == "sub")
        end

        render json: { streaming_sources: us_sources }
      else
        render json: { error: "No Watchmode title found for IMDB ID #{imdb_id}" }, status: :not_found
      end
    else
      render json: { error: "IMDB ID is missing" }, status: :bad_request
    end
  end

end
