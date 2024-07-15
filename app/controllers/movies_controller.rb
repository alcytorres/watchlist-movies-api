class MoviesController < ApplicationController

  def index
    p "current_user"
    p current_user
    p "current_user"
    @movies = Movie.all
    render :index
  end

  def show
    @movie = Movie.find_by(id: params[:id])
    render :show
  end

end
