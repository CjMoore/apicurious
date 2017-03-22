Rails.application.routes.draw do

  get '/auth/reddit/callback', to: "sessions#create"
  get '/dashboard', to: "dashboard#show"
  get '/logout', to: "sessions#destroy"

  get '/subreddit', to: "subreddit#show"

  root "home#show"

end
