class MoviesController < ApplicationController

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


end
