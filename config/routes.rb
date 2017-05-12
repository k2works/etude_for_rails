Rails.application.routes.draw do
  namespace :beer_lists do
    resources :beer_list, only: [:index]
  end
end
