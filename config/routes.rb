# == Route Map
#
#                                         Prefix Verb URI Pattern                                           Controller#Action
#                      html_css_book_index_index GET  /html_css_book/index(.:format)                        html_css_book/index#index
#                  html_css_book_campaign_submit GET  /html_css_book/campaign/:campaign_id/submit(.:format) html_css_book/campaign#submit
#                   html_css_book_campaign_index GET  /html_css_book/campaign(.:format)                     html_css_book/campaign#index
#                    html_css_book_article_index GET  /html_css_book/article(.:format)                      html_css_book/article#index
#              react_beginners_guide_excel_index GET  /react_beginners_guide/excel(.:format)                react_beginners_guide/excel#index
# discovery_react_beginners_guide_whinepad_index GET  /react_beginners_guide/whinepad/discovery(.:format)   react_beginners_guide/whinepad#discovery
#           react_beginners_guide_whinepad_index GET  /react_beginners_guide/whinepad(.:format)             react_beginners_guide/whinepad#index
#           intro_to_reacts_intro_to_react_index GET  /intro_to_reacts/intro_to_react(.:format)             intro_to_reacts/intro_to_react#index
#                     beer_lists_beer_list_index GET  /beer_lists/beer_list(.:format)                       beer_lists/beer_list#index
#

Rails.application.routes.draw do
  namespace :html_css_book do
    resources :index, only: [:index]
    resources :campaign, only: [:index] do
      get 'submit', to: 'campaign#submit'
    end
    resources :article, only: [:index]
  end

  namespace :react_beginners_guide do
    resources :excel, only: [:index]
    resources :whinepad, only: [:index] do
      get :discovery, on: :collection
    end
  end

  namespace :intro_to_reacts do
    resources :intro_to_react, only: [:index]
  end

  namespace :beer_lists do
    resources :beer_list, only: [:index]
  end
end
