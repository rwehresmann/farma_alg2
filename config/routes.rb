Rails.application.routes.draw do
  devise_for :users

  #authenticated :user do
  #  root to: "dashboard#home", as: :authenticated_root
  #end

  root to: "static_pages#home"

  namespace :dashboard do
    get "/home",     to: "dashboard#home"
    get "/timeline", to: "dashboard#timeline"
    get "/search",   to: "dashboard#search"
    get "/tags",     to: "dashboard#tags"
    get "/help",     to: "dashboard#help"

    put "fulltext_search/page/:page", action: "fulltext_search", as: "fulltext_search"
    put "timeline_search/page/:page", action: "timeline_search", as: "timeline_search"
    put "graph_search/page/:page", action: "graph_search", as: "graph_search"
    put "tags_search/page/:page", action: "tags_search", as: "tags_search"
    put "tags_search_aat", action: "tags_search_aat", as: "tags_search_aat"

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
