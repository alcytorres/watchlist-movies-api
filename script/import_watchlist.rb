# Reusable import: add movie titles from tmp/watchlist_titles.txt to Watchlist for user id 1.
# Usage:
#   1. Put one movie title per line in tmp/watchlist_titles.txt
#   2. bundle exec rails runner script/import_watchlist.rb
require "net/http"
require "json"
require "socket"
require "uri"

USER_ID = 1
TITLES_FILE = Rails.root.join("tmp", "watchlist_titles.txt")

STREAMING_SERVICE_MAPPING = {
  "8" => "netflix",
  "9" => "amazon",
  "337" => "disney",
  "350" => "apple",
  "1899" => "max",
  "15" => "hulu",
  "531" => "paramount",
}.freeze

def tmdb_get(url)
  uri = url.is_a?(URI) ? url : URI(url)
  ipv4 = Socket.getaddrinfo(uri.host, uri.port, Socket::AF_INET, Socket::SOCK_STREAM).first[3]

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == "https")
  http.ipaddr = ipv4
  http.open_timeout = 5
  http.read_timeout = 8
  http.start { |conn| conn.get(uri.request_uri).body }
end

def fetch_movie_from_tmdb(title, api_key)
  search_url = URI(
    "https://api.themoviedb.org/3/search/movie?api_key=#{api_key}&query=#{URI.encode_www_form_component(title)}"
  )
  search_results = JSON.parse(tmdb_get(search_url))
  result = search_results["results"]&.first
  return nil unless result

  tmdb_id = result["id"]
  details_url = URI(
    "https://api.themoviedb.org/3/movie/#{tmdb_id}?api_key=#{api_key}&append_to_response=credits,external_ids"
  )
  details = JSON.parse(tmdb_get(details_url))

  providers_url = URI(
    "https://api.themoviedb.org/3/movie/#{tmdb_id}/watch/providers?api_key=#{api_key}"
  )
  providers = JSON.parse(tmdb_get(providers_url))
  us_providers = providers.dig("results", "US", "flatrate") || []
  streaming_services = us_providers.map do |provider|
    STREAMING_SERVICE_MAPPING[provider["provider_id"].to_s] || "other"
  end.uniq

  {
    title: details["title"] || title,
    image_url: details["poster_path"] ? "https://image.tmdb.org/t/p/w500#{details["poster_path"]}" : nil,
    description: details["overview"] || "No description available",
    director: details.dig("credits", "crew")&.find { |person| person["job"] == "Director" }&.[]("name") || "Unknown Director",
    release_year: details["release_date"]&.split("-")&.first || "Unknown Year",
    imdb_id: details.dig("external_ids", "imdb_id"),
    streaming_services: streaming_services,
  }
end

abort("Missing titles file: #{TITLES_FILE}") unless File.exist?(TITLES_FILE)

titles = File.readlines(TITLES_FILE, chomp: true)
             .map(&:strip)
             .reject { |line| line.empty? || line.start_with?("#") }

abort("No titles found in #{TITLES_FILE}") if titles.empty?

user = User.find_by(id: USER_ID)
abort("User #{USER_ID} not found") unless user

api_key = ENV["TMDB_API_KEY"]
abort("TMDB_API_KEY missing") if api_key.blank?

puts "Importing #{titles.length} title(s) to Watchlist for #{user.first_name} #{user.last_name} (id=#{user.id})..."

titles.each do |title|
  print "  #{title}... "

  data = fetch_movie_from_tmdb(title, api_key)
  unless data && data[:imdb_id].present?
    puts "SKIPPED (not found on TMDb)"
    next
  end

  movie = Movie.find_by(imdb_id: data[:imdb_id]) || Movie.create!(data)

  # Mutual exclusivity: already in Favorites cannot also be on Watchlist
  if FavoriteMovie.exists?(user_id: user.id, movie_id: movie.id)
    puts "SKIPPED (already in Favorites: #{movie.title}, #{movie.release_year})"
    next
  end

  watchlist_movie = WatchlistMovie.find_or_initialize_by(user_id: user.id, movie_id: movie.id)
  if watchlist_movie.persisted?
    puts "already in Watchlist (#{movie.title}, #{movie.release_year})"
  elsif watchlist_movie.save
    puts "ADDED (#{movie.title}, #{movie.release_year})"
  else
    puts "FAILED: #{watchlist_movie.errors.full_messages.join(", ")}"
  end
rescue => e
  puts "ERROR: #{e.class} - #{e.message}"
end

puts "Done. Watchlist count: #{user.watchlist_movies.count}"
