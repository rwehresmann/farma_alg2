Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "dashboard#home", as: :authenticated_root
  end

  root to: "static_pages#home"

  get "/home", to: "dashboard#home"
end
