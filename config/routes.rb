Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # authentication - who is using the app
  # authorization - who is allowed to do what

  # Defines the root path route ("/")
  # root "posts#index"

  post "/users" => "users#create"  # everyone
  post "/sessions" => "sessions#create"  # everyone


  get "/movies" => "movies#index"  # everyone
  get "/movies/:id" => "movies#show"  # everyone
  post "/movies" => "movies#create"  # logged in

  # This is a users favorite movies page.
  # The movies that they have added to the list will show here.
  # Add this to frontend
  get "/user_movies" => "movies#user_movies"  # logged in


  get "/favorite_movies" => "favorite_movies#index"
  post "/favorite_movies" => "favorite_movies#create"
  delete "/favorite_movies/:id" => "favorite_movies#destroy"


end
