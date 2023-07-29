Rails.application.routes.draw do
  devise_for :users
  root "health#hello"

  get "/courses", to: "course#index"
  get "/courses/:id", to: "course#show"

  get "/hello", to: "health#hello"
end
