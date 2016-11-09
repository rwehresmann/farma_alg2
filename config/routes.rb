Rails.application.routes.draw do
  get 'sessions/new'

  devise_for :users
  root to: "welcome#index"
end
