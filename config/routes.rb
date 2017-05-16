Rails.application.routes.draw do
  namespace :react_beginners_guide do
    resources :excel, only: [:index]
  end

  namespace :intro_to_reacts do
    resources :intro_to_react, only: [:index]
  end

  namespace :beer_lists do
    resources :beer_list, only: [:index]
  end
end
