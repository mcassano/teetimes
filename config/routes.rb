Rails.application.routes.draw do
  root "health#hello"

  get "/courses", to: "course#index"
  get "/courses/:id", to: "course#show"

  get "/hello", to: "health#hello"
end
