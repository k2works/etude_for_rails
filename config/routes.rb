# == Route Map
#
#                                         Prefix Verb URI Pattern                                           Controller#Action
#                          javascripts_top_index GET  /javascripts/top(.:format)                            javascripts/top#index
#                                           root GET  /                                                     home#index
#                     bootstraps_dashboard_index GET  /bootstraps/dashboard(.:format)                       bootstraps/dashboard#index
#                        bootstraps_layout_index GET  /bootstraps/layout(.:format)                          bootstraps/layout#index
#                          bootstraps_form_index GET  /bootstraps/form(.:format)                            bootstraps/form#index
#                            bootstraps_ui_index GET  /bootstraps/ui(.:format)                              bootstraps/ui#index
#                   bootstraps_java_script_index GET  /bootstraps/java_script(.:format)                     bootstraps/java_script#index
#                         bootstraps_affix_index GET  /bootstraps/affix(.:format)                           bootstraps/affix#index
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
  namespace :javascripts do
    resources :top, only:[:index]
  end

  root 'home#index'

  namespace :bootstraps do
    resources :dashboard, only: [:index]
    resources :layout, only: [:index]
    resources :form, only: [:index]
    resources :ui, only: [:index]
    resources :java_script, only: [:index]
    resources :affix, only: [:index]
  end

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
