Rails.application.routes.draw do
root to:'bing_search#index'
resources :supports
resources :bing_search, only: [:index]
end
