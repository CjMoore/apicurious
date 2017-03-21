Rails.application.routes.draw do

  get '/auth/reddit/callback', to: "sessions#create"
  get '/dashboard', to: "dashboard#show"

  root "home#show"

end
