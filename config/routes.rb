Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "dashboard#home", as: :authenticated_root
  end

  root to: "static_pages#home"

  namespace :dashboard do
    get "/home",     to: "dashboard#home"
    get "/timeline", to: "dashboard#timeline"
    get "/search",   to: "dashboard#search"
    get "/tags",     to: "dashboard#tags"
    get "/help",     to: "dashboard#help"

    resources :messages

    resources :teams, only: [:new,:edit,:update,:create,:destroy] do
      member do
        post :unenroll, to: "teams#unenroll"
      end
    end

    namespace :teams do
      get :available, to: "teams#available"
      post :enroll, to: "teams#enroll"
    end
  end
end
