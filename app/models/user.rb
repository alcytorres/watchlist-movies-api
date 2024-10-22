class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :favorite_movies
  has_many :movies, through: :favorite_movies


  # Associations for watchlist movies

  # A user can have multiple movies in their watchlist.
  has_many :watchlist_movies
  # A user can access the list of movies in their watchlist through the watchlist_movies table.
  has_many :movies_in_watchlist, through: :watchlist_movies, source: :movie

end
