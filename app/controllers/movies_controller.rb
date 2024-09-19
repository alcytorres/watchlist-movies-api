class MoviesController < ApplicationController
  require 'net/http'

  def index
    p "current_user"
    p current_user
    p "current_user"

    # @movies suggests the vairable holds a collection of movies
    # @movies = Movie.all

     # NEW: Exclude movies that the current user has already favorited
     @movies = Movie.where.not(id: current_user.favorite_movies.select(:movie_id))

    render :index
  end

  def user_movies
    @movies = current_user.movies
    render :index
  end

  def show
    @movie = Movie.find_by(id: params[:id])   # @movie suggests the vairable holds a single movie
    render :show
  end

  def create
    @movie = Movie.create(
      name: params[:name],
      image_url: params[:image_url],
      description: params[:description],
      director: params[:director],
      release_year: params[:release_year],
    )
    render :show
  end


  # NEW: Search for a movie by title in the TMDb API
  def search_tmdb
    tmdb_api_key = "REDACTED"
    query = params[:query]

    url = URI("https://api.themoviedb.org/3/search/movie?api_key=#{tmdb_api_key}&query=#{URI.encode_www_form_component(query)}")
    response = Net::HTTP.get(url)
    tmdb_results = JSON.parse(response)

    if tmdb_results["results"] && tmdb_results["results"].any?
      movie = tmdb_results["results"].first
      movie_id = movie["id"]

      # Fetch movie details and store in the database
      movie_details_url = URI("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{tmdb_api_key}&append_to_response=credits")
      movie_details_response = Net::HTTP.get(movie_details_url)
      movie_details = JSON.parse(movie_details_response)

      # Handle potential missing fields safely
      movie_title = movie_details["title"] || "Unknown Title"
      movie_description = movie_details["overview"] || "No description available"
      movie_release_date = movie_details["release_date"] ? movie_details["release_date"].split("-")[0] : "Unknown Year"
      movie_director = movie_details["credits"] && movie_details["credits"]["crew"] ?
                         movie_details["credits"]["crew"].find { |person| person["job"] == "Director" }&.[]("name") || "Unknown Director"
                         : "Unknown Director"
      movie_poster_path = movie_details["poster_path"] ? "https://image.tmdb.org/t/p/w500/#{movie_details["poster_path"]}" : nil

      # Save the movie to the database
      new_movie = Movie.create(
        name: movie_title,
        description: movie_description,
        release_year: movie_release_date,
        director: movie_director,
        image_url: movie_poster_path
      )

      # NEW: Fetch streaming availability from Watchmode API and filter by US region
      watchmode_api_key = "REDACTED"
      imdb_id = movie_details["imdb_id"]
      watchmode_url = URI("https://api.watchmode.com/v1/title/#{imdb_id}/sources/?apiKey=#{watchmode_api_key}")
      watchmode_response = Net::HTTP.get(watchmode_url)
      watchmode_results = JSON.parse(watchmode_response)

      # NEW: Filter streaming availability for US region only
      us_sources = watchmode_results.select do |source|
        source["region"] == "US" && (source["type"] == "free" || source["type"] == "sub")
      end

      render json: { movie: new_movie, streaming_sources: us_sources }
    else
      render json: { error: "Movie not found or no results available" }, status: :not_found
    end
  end

end
