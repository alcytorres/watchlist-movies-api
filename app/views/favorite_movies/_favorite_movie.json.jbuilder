json.id favorite_movie.id
json.user_id favorite_movie.user_id
json.movie do
  json.id favorite_movie.movie.id
  json.title favorite_movie.movie.title
  json.image_url favorite_movie.movie.image_url
  json.description favorite_movie.movie.description
  json.director favorite_movie.movie.director
  json.release_year favorite_movie.movie.release_year
  json.imdb_id favorite_movie.movie.imdb_id
  json.streaming_services favorite_movie.movie.streaming_services
end
json.created_at favorite_movie.created_at
json.updated_at favorite_movie.updated_at
