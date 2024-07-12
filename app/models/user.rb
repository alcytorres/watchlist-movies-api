class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :favorite_movies
  has_many :movies, through: :favorite_movies
end
