Rails.application.routes.draw do
root to:'bing_search#index'

resources :bing_search, only: [:index]
end
