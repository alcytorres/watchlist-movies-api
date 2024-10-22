class ChangeFavoriteMoviesToReferences < ActiveRecord::Migration[7.1]
  def change
    remove_column :favorite_movies, :user_id, :integer
    remove_column :favorite_movies, :movie_id, :integer
    add_reference :favorite_movies, :user, null: false, foreign_key: true
    add_reference :favorite_movies, :movie, null: false, foreign_key: true
  end
end
