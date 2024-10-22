json.id movie.id
json.title movie.title
json.image_url movie.image_url
json.description movie.description
json.director movie.director
json.release_year movie.release_year
json.imdb_id movie.imdb_id  # Add this line to include imdb_id
json.streaming_services movie.streaming_services # Add streaming services
json.favoritemovie_id FavoriteMovie.find_by(user_id: current_user.id, movie_id: movie.id)&.id
json.created_at movie.created_at
json.updated_at movie.updated_at
