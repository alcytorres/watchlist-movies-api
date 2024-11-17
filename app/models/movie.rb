class Movie < ApplicationRecord
  has_many :favorite_movies
  has_many :users, through: :favorite_movies


  # Associations for watchlist movies

  # A movie can be part of multiple users' watchlists
  has_many :watchlist_movies

  # A movie can have multiple users who added it to their watchlist, accessible through the watchlist_movies table.
  has_many :users_with_movie_in_watchlist, through: :watchlist_movies, source: :user

  validates :title, presence: true
  validates :imdb_id, uniqueness: true  # Ensure uniqueness of IMDB ID
  validate :validate_streaming_services

  # Ensure streaming services is a JSON array
  def validate_streaming_services
    unless streaming_services.is_a?(Array)
      errors.add(:streaming_services, "must be an array of services")
    end
  end

end
