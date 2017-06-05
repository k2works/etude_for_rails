# == Route Map
#
#                                         Prefix Verb URI Pattern                                           Controller#Action
#                           css_design_top_index GET  /css_design/top(.:format)                             css_design/top#index
#                             css_design_chap4_1 GET  /css_design/chap4_1(.:format)                         css_design/top#chap4_1
#                             css_design_chap4_2 GET  /css_design/chap4_2(.:format)                         css_design/top#chap4_2
#                             css_design_chap5_1 GET  /css_design/chap5_1(.:format)                         css_design/top#chap5_1
#                            sass_base_top_index GET  /sass_base/top(.:format)                              sass_base/top#index
#                                sass_base_chap3 GET  /sass_base/chap3(.:format)                            sass_base/top#chap3
#                                sass_base_chap4 GET  /sass_base/chap4(.:format)                            sass_base/top#chap4
#                             css_base_top_index GET  /css_base/top(.:format)                               css_base/top#index
#                       css_base_chapter04_index GET  /css_base/chapter04(.:format)                         css_base/chapter04#index
#                       css_base_chapter05_index GET  /css_base/chapter05(.:format)                         css_base/chapter05#index
#                       css_base_chapter06_index GET  /css_base/chapter06(.:format)                         css_base/chapter06#index
#                       css_base_chapter07_index GET  /css_base/chapter07(.:format)                         css_base/chapter07#index
#                       css_base_chapter08_index GET  /css_base/chapter08(.:format)                         css_base/chapter08#index
#                css_base_chapter10_sample_10_01 GET  /css_base/chapter10/sample_10_01(.:format)            css_base/chapter10#sample_10_01
#                          css_base_chapter10_02 GET  /css_base/chapter10_02/index(.:format)                css_base/chapter10#sample_10_02
#                    point_css_base_chapter10_02 GET  /css_base/chapter10_02/point(.:format)                css_base/chapter10#sample_10_02_point
#                   course_css_base_chapter10_02 GET  /css_base/chapter10_02/course(.:format)               css_base/chapter10#sample_10_02_course
#                    trial_css_base_chapter10_02 GET  /css_base/chapter10_02/trial(.:format)                css_base/chapter10#sample_10_02_trial
#                   access_css_base_chapter10_02 GET  /css_base/chapter10_02/access(.:format)               css_base/chapter10#sample_10_02_access
#                  contact_css_base_chapter10_02 GET  /css_base/chapter10_02/contact(.:format)              css_base/chapter10#sample_10_02_contact
#                          css_base_chapter10_03 GET  /css_base/chapter10_03/index(.:format)                css_base/chapter10#sample_10_03
#                    about_css_base_chapter10_03 GET  /css_base/chapter10_03/about(.:format)                css_base/chapter10#sample_10_03_about
#                  service_css_base_chapter10_03 GET  /css_base/chapter10_03/service(.:format)              css_base/chapter10#sample_10_03_service
#                  contact_css_base_chapter10_03 GET  /css_base/chapter10_03/contact(.:format)              css_base/chapter10#sample_10_03_contact
#                     blog_css_base_chapter10_03 GET  /css_base/chapter10_03/blog(.:format)                 css_base/chapter10#sample_10_03_blog
#                          javascripts_top_index GET  /javascripts/top(.:format)                            javascripts/top#index
#                  javascripts_samples_sample_01 GET  /javascripts/samples/sample_01(.:format)              javascripts/samples#sample_01
#                  javascripts_samples_sample_02 GET  /javascripts/samples/sample_02(.:format)              javascripts/samples#sample_02
#                  javascripts_samples_sample_03 GET  /javascripts/samples/sample_03(.:format)              javascripts/samples#sample_03
#                  javascripts_samples_sample_04 GET  /javascripts/samples/sample_04(.:format)              javascripts/samples#sample_04
#                  javascripts_samples_sample_05 GET  /javascripts/samples/sample_05(.:format)              javascripts/samples#sample_05
#                  javascripts_samples_sample_06 GET  /javascripts/samples/sample_06(.:format)              javascripts/samples#sample_06
#                  javascripts_samples_sample_07 GET  /javascripts/samples/sample_07(.:format)              javascripts/samples#sample_07
#                  javascripts_samples_sample_08 GET  /javascripts/samples/sample_08(.:format)              javascripts/samples#sample_08
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
#                                           root GET  /                                                     home#index
#

Rails.application.routes.draw do
  namespace :css_design do
    resources :top, only:[:index]
    get 'chap4_1', to: 'top#chap4_1'
    get 'chap4_2', to: 'top#chap4_2'
    get 'chap5_1', to: 'top#chap5_1'
  end

  namespace :sass_base do
    resources :top, only:[:index]
    get 'chap3', to: 'top#chap3'
    get 'chap4', to: 'top#chap4'
  end

  namespace :css_base do
    resources :top, only:[:index]
    resources :chapter04, only:[:index]
    resources :chapter05, only:[:index]
    resources :chapter06, only:[:index]
    resources :chapter07, only:[:index]
    resources :chapter08, only:[:index]
    get 'chapter10/sample_10_01'
    resource :chapter10_02, only:[:index] do
      get 'index', to: 'chapter10#sample_10_02'
      get 'point', to: 'chapter10#sample_10_02_point'
      get 'course', to: 'chapter10#sample_10_02_course'
      get 'trial', to: 'chapter10#sample_10_02_trial'
      get 'access', to: 'chapter10#sample_10_02_access'
      get 'contact', to: 'chapter10#sample_10_02_contact'
    end
    resource :chapter10_03, only:[:index] do
      get 'index', to: 'chapter10#sample_10_03'
      get 'about', to: 'chapter10#sample_10_03_about'
      get 'service', to: 'chapter10#sample_10_03_service'
      get 'contact', to: 'chapter10#sample_10_03_contact'
      get 'blog', to: 'chapter10#sample_10_03_blog'
    end
  end

  namespace :javascripts do
    resources :top, only:[:index]
    get 'samples/sample_01'
    get 'samples/sample_02'
    get 'samples/sample_03'
    get 'samples/sample_04'
    get 'samples/sample_05'
    get 'samples/sample_06'
    get 'samples/sample_07'
    get 'samples/sample_08'
  end

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

  root 'home#index'
end
