Rails.application.routes.draw do
  namespace :intro_to_reacts do
    get 'intro_to_react/index'
    resources :intro_to_react, only: [:index]
  end

  namespace :beer_lists do
    resources :beer_list, only: [:index]
  end
end
