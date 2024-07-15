class MoviesController < ApplicationController

  def index
    p "current_user"
    p current_user
    p "current_user"
    @movies = Movie.all
    render :index
  end

end
