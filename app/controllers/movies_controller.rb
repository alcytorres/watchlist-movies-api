class MoviesController < ApplicationController

  def index
    p "current_user"
    p current_user
    p "current_user"
    @movies = Movie.all
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
    )
    render :show
  end


end
