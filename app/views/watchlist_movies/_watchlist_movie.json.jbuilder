json.id watchlist_movie.id
json.user_id watchlist_movie.user_id
json.movie do
  json.id watchlist_movie.movie.id
  json.title watchlist_movie.movie.title
  json.image_url watchlist_movie.movie.image_url
  json.description watchlist_movie.movie.description
  json.director watchlist_movie.movie.director
  json.release_year watchlist_movie.movie.release_year
  json.imdb_id watchlist_movie.movie.imdb_id
  json.streaming_services watchlist_movie.movie.streaming_services
end
json.created_at watchlist_movie.created_at
json.updated_at watchlist_movie.updated_at
