# Watchlist Movies API

The backend for a full-stack movie app to search films, see where to stream them, build a watchlist and favorites, and get AI-powered recommendations.

![App demo](https://raw.githubusercontent.com/alcytorres/watchlist-movies-frontend/main/demo.gif)

## What It Does
Search the TMDb catalog and view details like streaming availability. Save movies to your watchlist or favorites, then filter and sort them. Pick a few favorite movies, and the app uses OpenAI to recommend similar films and explain why they're a good match.

## Tech Stack
- **Backend:** Ruby on Rails, PostgreSQL, JWT, Dotenv
- **Frontend:** React, React Router, Axios, Bootstrap
- **APIs:** TMDb (movie/streaming data), OpenAI (recommendations)

## Features
- Secure sign up / log in (JWT)
- Movie search with details and streaming availability
- Watchlist and favorites endpoints (add, view, remove)
- Filter and sort user lists by release year and streaming service
- AI recommendations from 2–6 selected favorites (falls back to TMDb if OpenAI is unavailable)
- Bulk import scripts for favorites and watchlist (see below)

## Related Repo
This is the **Rails API backend**. The **React frontend** (with a demo GIF) lives here: [watchlist-movies-frontend](https://github.com/alcytorres/watchlist-movies-frontend).
You need both running to use the app.

## Getting Started
Requires Ruby 3.2.2, Rails 7.1.3.4, and PostgreSQL. You also need a [TMDb API key](https://developer.themoviedb.org/docs/getting-started) and an [OpenAI API key](https://platform.openai.com/api-keys).

```bash
git clone https://github.com/alcytorres/watchlist-movies-api.git
cd watchlist-movies-api
bundle install
rails db:setup
```

Create a `.env` in the project root:

```
TMDB_API_KEY=your_tmdb_api_key_here
OPENAI_API_KEY=your_openai_api_key_here
```

Start the server with `rails server`. Then start the [frontend](https://github.com/alcytorres/watchlist-movies-frontend).

**Notes:** Keep API keys in `.env` (never commit them), and configure CORS so the frontend can call the API.

## Bulk Import (optional)
Add many movies at once from a list of titles instead of searching one by one.

**Favorites:** put one title per line in `tmp/favorite_titles.txt`, then run:
```bash
bundle exec rails runner tmp/import_favorites.rb
```

**Watchlist:** put one title per line in `tmp/watchlist_titles.txt`, then run:
```bash
bundle exec rails runner tmp/import_watchlist.rb
```

Each script looks titles up on TMDb, creates the movie if needed, and adds it for the user in `USER_ID` (default: `1`). On a fresh setup, the first account you create is usually `1`, so you often don't need to change it. If you have multiple users, list them with:
```bash
bin/rails runner 'User.all.each { |u| puts "#{u.id}: #{u.email}" }'
```
then update `USER_ID` in the import scripts. Skips duplicates; watchlist/favorites stay mutually exclusive. Requires `TMDB_API_KEY` in `.env`; use clear titles (e.g. "The Godfather") so TMDb finds the right movie.
