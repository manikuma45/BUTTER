Rails.application.routes.draw do
resources :sessions, only: [:new, :create, :destroy]
resources :supports
resources :bing_search, only: [:index]
end
