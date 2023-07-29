Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  get "/playdates", to: "playdate#show"

  get "/courses", to: "course#index"
  get "/courses/:id", to: "course#show"

  get "/hello", to: "health#hello"
end
