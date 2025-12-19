class RecommendationsController < ApplicationController
  require 'net/http'
  require 'json'

  skip_before_action :verify_authenticity_token

  def create
    # Get selected movie IDs from params
    selected_movie_ids = params[:movie_ids] || []

    if selected_movie_ids.empty? || selected_movie_ids.length < 2
      render json: { error: "Please select at least 2 movies" }, status: :unprocessable_entity
      return
    end

    if selected_movie_ids.length > 6
      render json: { error: "Please select maximum 6 movies" }, status: :unprocessable_entity
      return
    end

    # Get the selected favorite movies
    selected_favorites = current_user.favorite_movies.where(id: selected_movie_ids).includes(:movie)

    if selected_favorites.length != selected_movie_ids.length
      render json: { error: "Some selected movies not found" }, status: :not_found
      return
    end

    # Build list of movie titles for OpenAI
    movie_titles = selected_favorites.map { |fm| fm.movie.title }.join(", ")

    # Call OpenAI API
    recommendations_data = get_openai_recommendations(movie_titles)

    if recommendations_data[:error]
      render json: { error: recommendations_data[:error] }, status: :internal_server_error
      return
    end

    # Fetch full movie details from TMDb for each recommendation
    full_recommendations = fetch_movie_details(recommendations_data[:movies])

    render json: {
      recommendations: full_recommendations,
      based_on: selected_favorites.map { |fm| { id: fm.movie.id, title: fm.movie.title } }
    }
  end

  private

  def get_openai_recommendations(movie_titles)
    require 'openai'

    # Try OpenAI first
    begin
      client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])

      prompt = %Q{
Based on these favorite movies: #{movie_titles}

Suggest exactly 6 similar movies that the user might enjoy. For each movie, provide:
1. The exact movie title (must be a real, well-known movie)
2. A brief one-sentence explanation of why they might like it based on their favorites

Return ONLY a JSON array in this exact format:
[
  {"title": "Movie Title", "explanation": "Why they'll like it"},
  {"title": "Movie Title", "explanation": "Why they'll like it"}
]

Do not include any other text, only the JSON array.
}

      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [
            { role: "user", content: prompt }
          ],
          temperature: 0.7,
          max_tokens: 500
        }
      )

      content = response.dig("choices", 0, "message", "content")

      # Clean up the response (remove markdown code blocks if present)
      content = content.gsub(/\n?/, '').gsub(/```\n?/, '').strip

      movies = JSON.parse(content)

      { movies: movies }
    rescue => e
      # Log the error for debugging
      puts "OpenAI Error: #{e.message}"
      puts "Error class: #{e.class}"

      # Fallback to TMDb if OpenAI fails (rate limit, no credits, etc.)
      if e.message.include?("429") || e.message.include?("rate limit") || e.message.include?("insufficient_quota") || e.message.include?("401")
        puts "Falling back to TMDb recommendations"
        return get_tmdb_recommendations_fallback(movie_titles)
      else
        puts "OpenAI failed with error: #{e.message}"
        return { error: "Failed to get recommendations: #{e.message}" }
      end
    end
  end

  def get_tmdb_recommendations_fallback(movie_titles)
    # Parse movie titles from the string
    titles = movie_titles.split(", ").map(&:strip)
    tmdb_api_key = ENV['TMDB_API_KEY']
    all_recommendations = []

    # Get recommendations from TMDb for each favorite
    titles.each do |title|
      begin
        # Search for the movie
        search_url = URI("https://api.themoviedb.org/3/search/movie?api_key=#{tmdb_api_key}&query=#{URI.encode_www_form_component(title)}")
        search_response = Net::HTTP.get(search_url)
        search_results = JSON.parse(search_response)

        if search_results["results"] && search_results["results"].any?
          tmdb_id = search_results["results"][0]["id"]

          # Get recommendations from TMDb
          rec_url = URI("https://api.themoviedb.org/3/movie/#{tmdb_id}/recommendations?api_key=#{tmdb_api_key}")
          rec_response = Net::HTTP.get(rec_url)
          rec_results = JSON.parse(rec_response)

          if rec_results["results"] && rec_results["results"].any?
            # Get top 2-3 recommendations from each movie
            all_recommendations.concat(rec_results["results"].first(3))
          end
        end
      rescue => e
        # Skip if this movie fails, continue with others
        next
      end
    end

    # Deduplicate by TMDb ID and limit to 6
    unique_recommendations = all_recommendations.uniq { |m| m["id"] }.first(6)

    # Format like OpenAI response with explanation text
    movies = unique_recommendations.map do |movie|
      {
        "title" => movie["title"],
        "explanation" => "Similar to your favorite movies - recommended based on TMDb's algorithm"
      }
    end

    { movies: movies }
  end

  def fetch_movie_details(recommendations)
    tmdb_api_key = ENV['TMDB_API_KEY']
    full_recommendations = []

    recommendations.each do |rec|
      movie_title = rec["title"]
      original_explanation = rec["explanation"] # Preserve the AI explanation

      # Search TMDb for the movie
      search_url = URI("https://api.themoviedb.org/3/search/movie?api_key=#{tmdb_api_key}&query=#{URI.encode_www_form_component(movie_title)}")
      search_response = Net::HTTP.get(search_url)
      search_results = JSON.parse(search_response)

      if search_results["results"] && search_results["results"].any?
        # Get the first (most relevant) result
        tmdb_movie = search_results["results"][0]
        tmdb_id = tmdb_movie["id"]

        # Fetch full movie details
        movie_details_url = URI("https://api.themoviedb.org/3/movie/#{tmdb_id}?api_key=#{tmdb_api_key}&append_to_response=credits,external_ids")
        movie_details_response = Net::HTTP.get(movie_details_url)
        movie_details = JSON.parse(movie_details_response)

        # Get streaming providers
        watch_providers_url = URI("https://api.themoviedb.org/3/movie/#{tmdb_id}/watch/providers?api_key=#{tmdb_api_key}")
        watch_providers_response = Net::HTTP.get(watch_providers_url)
        watch_providers = JSON.parse(watch_providers_response)

        # Extract US streaming services
        streaming_service_mapping = {
          "8" => "netflix",
          "9" => "amazon",
          "337" => "disney",
          "350" => "apple",
          "1899" => "max",
          "15" => "hulu",
          "531" => "paramount",
        }

        us_providers = watch_providers.dig("results", "US", "flatrate") || []
        normalized_sources = us_providers.map do |provider|
          streaming_service_mapping[provider["provider_id"].to_s] || "other"
        end

        # Build movie data - use original explanation from OpenAI
        movie_data = {
          tmdb_id: tmdb_id,
          title: movie_details["title"] || movie_title,
          description: movie_details["overview"] || original_explanation,
          director: movie_details.dig("credits", "crew")&.find { |person| person["job"] == "Director" }&.[]("name") || "Unknown Director",
          release_year: movie_details["release_date"] ? movie_details["release_date"].split("-")[0] : "Unknown Year",
          image_url: movie_details["poster_path"] ? "https://image.tmdb.org/t/p/w500#{movie_details["poster_path"]}" : nil,
          imdb_id: movie_details.dig("external_ids", "imdb_id"),
          streaming_services: normalized_sources.uniq,
          explanation: original_explanation || "Similar to your favorites"
        }

        full_recommendations << movie_data
      end
    end

    full_recommendations
  end
end
