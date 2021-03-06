# == Route Map
#
#                                         Prefix Verb   URI Pattern                                                         Controller#Action
#                            rails_tutorial_root GET    /rails_tutorial(.:format)                                           rails_tutorial/application#hello
#                  rails_tutorial_toy_microposts GET    /rails_tutorial/toy/microposts(.:format)                            rails_tutorial/toy/microposts#index
#                                                POST   /rails_tutorial/toy/microposts(.:format)                            rails_tutorial/toy/microposts#create
#               new_rails_tutorial_toy_micropost GET    /rails_tutorial/toy/microposts/new(.:format)                        rails_tutorial/toy/microposts#new
#              edit_rails_tutorial_toy_micropost GET    /rails_tutorial/toy/microposts/:id/edit(.:format)                   rails_tutorial/toy/microposts#edit
#                   rails_tutorial_toy_micropost GET    /rails_tutorial/toy/microposts/:id(.:format)                        rails_tutorial/toy/microposts#show
#                                                PATCH  /rails_tutorial/toy/microposts/:id(.:format)                        rails_tutorial/toy/microposts#update
#                                                PUT    /rails_tutorial/toy/microposts/:id(.:format)                        rails_tutorial/toy/microposts#update
#                                                DELETE /rails_tutorial/toy/microposts/:id(.:format)                        rails_tutorial/toy/microposts#destroy
#                       rails_tutorial_toy_users GET    /rails_tutorial/toy/users(.:format)                                 rails_tutorial/toy/users#index
#                                                POST   /rails_tutorial/toy/users(.:format)                                 rails_tutorial/toy/users#create
#                    new_rails_tutorial_toy_user GET    /rails_tutorial/toy/users/new(.:format)                             rails_tutorial/toy/users#new
#                   edit_rails_tutorial_toy_user GET    /rails_tutorial/toy/users/:id/edit(.:format)                        rails_tutorial/toy/users#edit
#                        rails_tutorial_toy_user GET    /rails_tutorial/toy/users/:id(.:format)                             rails_tutorial/toy/users#show
#                                                PATCH  /rails_tutorial/toy/users/:id(.:format)                             rails_tutorial/toy/users#update
#                                                PUT    /rails_tutorial/toy/users/:id(.:format)                             rails_tutorial/toy/users#update
#                                                DELETE /rails_tutorial/toy/users/:id(.:format)                             rails_tutorial/toy/users#destroy
#                        rails_tutorial_toy_root GET    /rails_tutorial/toy(.:format)                                       rails_tutorial/toy/users#index
#                     rails_tutorial_sample_root GET    /rails_tutorial/sample(.:format)                                    rails_tutorial/sample/static_pages#home
#                     rails_tutorial_sample_help GET    /rails_tutorial/sample/help(.:format)                               rails_tutorial/sample/static_pages#help
#                    rails_tutorial_sample_about GET    /rails_tutorial/sample/about(.:format)                              rails_tutorial/sample/static_pages#about
#                  rails_tutorial_sample_contact GET    /rails_tutorial/sample/contact(.:format)                            rails_tutorial/sample/static_pages#contact
#                   rails_tutorial_sample_signup GET    /rails_tutorial/sample/signup(.:format)                             rails_tutorial/sample/users#new
#                                                POST   /rails_tutorial/sample/signup(.:format)                             rails_tutorial/sample/users#create
#                    rails_tutorial_sample_login GET    /rails_tutorial/sample/login(.:format)                              rails_tutorial/sample/sessions#new
#                                                POST   /rails_tutorial/sample/login(.:format)                              rails_tutorial/sample/sessions#create
#                   rails_tutorial_sample_logout DELETE /rails_tutorial/sample/logout(.:format)                             rails_tutorial/sample/sessions#destroy
#           following_rails_tutorial_sample_user GET    /rails_tutorial/sample/users/:id/following(.:format)                rails_tutorial/sample/users#following
#           followers_rails_tutorial_sample_user GET    /rails_tutorial/sample/users/:id/followers(.:format)                rails_tutorial/sample/users#followers
#                    rails_tutorial_sample_users GET    /rails_tutorial/sample/users(.:format)                              rails_tutorial/sample/users#index
#                                                POST   /rails_tutorial/sample/users(.:format)                              rails_tutorial/sample/users#create
#                 new_rails_tutorial_sample_user GET    /rails_tutorial/sample/users/new(.:format)                          rails_tutorial/sample/users#new
#                edit_rails_tutorial_sample_user GET    /rails_tutorial/sample/users/:id/edit(.:format)                     rails_tutorial/sample/users#edit
#                     rails_tutorial_sample_user GET    /rails_tutorial/sample/users/:id(.:format)                          rails_tutorial/sample/users#show
#                                                PATCH  /rails_tutorial/sample/users/:id(.:format)                          rails_tutorial/sample/users#update
#                                                PUT    /rails_tutorial/sample/users/:id(.:format)                          rails_tutorial/sample/users#update
#                                                DELETE /rails_tutorial/sample/users/:id(.:format)                          rails_tutorial/sample/users#destroy
#                                                GET    /rails_tutorial/sample/users(.:format)                              rails_tutorial/sample/users#index
#                                                POST   /rails_tutorial/sample/users(.:format)                              rails_tutorial/sample/users#create
#                                                GET    /rails_tutorial/sample/users/new(.:format)                          rails_tutorial/sample/users#new
#                                                GET    /rails_tutorial/sample/users/:id/edit(.:format)                     rails_tutorial/sample/users#edit
#                                                GET    /rails_tutorial/sample/users/:id(.:format)                          rails_tutorial/sample/users#show
#                                                PATCH  /rails_tutorial/sample/users/:id(.:format)                          rails_tutorial/sample/users#update
#                                                PUT    /rails_tutorial/sample/users/:id(.:format)                          rails_tutorial/sample/users#update
#                                                DELETE /rails_tutorial/sample/users/:id(.:format)                          rails_tutorial/sample/users#destroy
#  edit_rails_tutorial_sample_account_activation GET    /rails_tutorial/sample/account_activations/:id/edit(.:format)       rails_tutorial/sample/account_activations#edit
#          rails_tutorial_sample_password_resets POST   /rails_tutorial/sample/password_resets(.:format)                    rails_tutorial/sample/password_resets#create
#       new_rails_tutorial_sample_password_reset GET    /rails_tutorial/sample/password_resets/new(.:format)                rails_tutorial/sample/password_resets#new
#      edit_rails_tutorial_sample_password_reset GET    /rails_tutorial/sample/password_resets/:id/edit(.:format)           rails_tutorial/sample/password_resets#edit
#           rails_tutorial_sample_password_reset PATCH  /rails_tutorial/sample/password_resets/:id(.:format)                rails_tutorial/sample/password_resets#update
#                                                PUT    /rails_tutorial/sample/password_resets/:id(.:format)                rails_tutorial/sample/password_resets#update
#               rails_tutorial_sample_microposts POST   /rails_tutorial/sample/microposts(.:format)                         rails_tutorial/sample/microposts#create
#                rails_tutorial_sample_micropost DELETE /rails_tutorial/sample/microposts/:id(.:format)                     rails_tutorial/sample/microposts#destroy
#            rails_tutorial_sample_relationships POST   /rails_tutorial/sample/relationships(.:format)                      rails_tutorial/sample/relationships#create
#             rails_tutorial_sample_relationship DELETE /rails_tutorial/sample/relationships/:id(.:format)                  rails_tutorial/sample/relationships#destroy
#                              baukis_staff_root GET    /baukis(.:format)                                                   baukis/staff/top#index
#                             baukis_staff_login GET    /baukis/login(.:format)                                             baukis/staff/sessions#new
#                           baukis_staff_session DELETE /baukis/session(.:format)                                           baukis/staff/sessions#destroy
#                                                POST   /baukis/session(.:format)                                           baukis/staff/sessions#create
#                   confirm_baukis_staff_account PATCH  /baukis/account/confirm(.:format)                                   baukis/staff/accounts#confirm
#                      edit_baukis_staff_account GET    /baukis/account/edit(.:format)                                      baukis/staff/accounts#edit
#                           baukis_staff_account GET    /baukis/account(.:format)                                           baukis/staff/accounts#show
#                                                PATCH  /baukis/account(.:format)                                           baukis/staff/accounts#update
#                                                PUT    /baukis/account(.:format)                                           baukis/staff/accounts#update
#                     edit_baukis_staff_password GET    /baukis/password/edit(.:format)                                     baukis/staff/passwords#edit
#                          baukis_staff_password GET    /baukis/password(.:format)                                          baukis/staff/passwords#show
#                                                PATCH  /baukis/password(.:format)                                          baukis/staff/passwords#update
#                                                PUT    /baukis/password(.:format)                                          baukis/staff/passwords#update
#                         baukis_staff_customers GET    /baukis/customers(.:format)                                         baukis/staff/customers#index
#                                                POST   /baukis/customers(.:format)                                         baukis/staff/customers#create
#                      new_baukis_staff_customer GET    /baukis/customers/new(.:format)                                     baukis/staff/customers#new
#                     edit_baukis_staff_customer GET    /baukis/customers/:id/edit(.:format)                                baukis/staff/customers#edit
#                          baukis_staff_customer GET    /baukis/customers/:id(.:format)                                     baukis/staff/customers#show
#                                                PATCH  /baukis/customers/:id(.:format)                                     baukis/staff/customers#update
#                                                PUT    /baukis/customers/:id(.:format)                                     baukis/staff/customers#update
#                                                DELETE /baukis/customers/:id(.:format)                                     baukis/staff/customers#destroy
#                   entries_baukis_staff_program PATCH  /baukis/programs/:id/entries(.:format)                              baukis/staff/programs#entries
#                          baukis_staff_programs GET    /baukis/programs(.:format)                                          baukis/staff/programs#index
#                                                POST   /baukis/programs(.:format)                                          baukis/staff/programs#create
#                       new_baukis_staff_program GET    /baukis/programs/new(.:format)                                      baukis/staff/programs#new
#                      edit_baukis_staff_program GET    /baukis/programs/:id/edit(.:format)                                 baukis/staff/programs#edit
#                           baukis_staff_program GET    /baukis/programs/:id(.:format)                                      baukis/staff/programs#show
#                                                PATCH  /baukis/programs/:id(.:format)                                      baukis/staff/programs#update
#                                                PUT    /baukis/programs/:id(.:format)                                      baukis/staff/programs#update
#                                                DELETE /baukis/programs/:id(.:format)                                      baukis/staff/programs#destroy
#                  inbound_baukis_staff_messages GET    /baukis/messages/inbound(.:format)                                  baukis/staff/messages#inbound
#                 outbound_baukis_staff_messages GET    /baukis/messages/outbound(.:format)                                 baukis/staff/messages#outbound
#                  deleted_baukis_staff_messages GET    /baukis/messages/deleted(.:format)                                  baukis/staff/messages#deleted
#                    count_baukis_staff_messages GET    /baukis/messages/count(.:format)                                    baukis/staff/messages#count
#                       tag_baukis_staff_message POST   /baukis/messages/:id/tag(.:format)                                  baukis/staff/messages#tag
#                                                DELETE /baukis/messages/:id/tag(.:format)                                  baukis/staff/messages#tag
#             confirm_baukis_staff_message_reply POST   /baukis/messages/:message_id/reply/confirm(.:format)                baukis/staff/replies#confirm
#                 new_baukis_staff_message_reply GET    /baukis/messages/:message_id/reply/new(.:format)                    baukis/staff/replies#new
#                     baukis_staff_message_reply POST   /baukis/messages/:message_id/reply(.:format)                        baukis/staff/replies#create
#                          baukis_staff_messages GET    /baukis/messages(.:format)                                          baukis/staff/messages#index
#                           baukis_staff_message GET    /baukis/messages/:id(.:format)                                      baukis/staff/messages#show
#                                                DELETE /baukis/messages/:id(.:format)                                      baukis/staff/messages#destroy
#              inbound_baukis_staff_tag_messages GET    /baukis/tags/:tag_id/messages/inbound(.:format)                     baukis/staff/messages#inbound
#             outbound_baukis_staff_tag_messages GET    /baukis/tags/:tag_id/messages/outbound(.:format)                    baukis/staff/messages#outbound
#              deleted_baukis_staff_tag_messages GET    /baukis/tags/:tag_id/messages/deleted(.:format)                     baukis/staff/messages#deleted
#                      baukis_staff_tag_messages GET    /baukis/tags/:tag_id/messages(.:format)                             baukis/staff/messages#index
#                              baukis_admin_root GET    /baukis/admin(.:format)                                             baukis/admin/top#index
#                             baukis_admin_login GET    /baukis/admin/login(.:format)                                       baukis/admin/sessions#new
#                           baukis_admin_session DELETE /baukis/admin/session(.:format)                                     baukis/admin/sessions#destroy
#                                                POST   /baukis/admin/session(.:format)                                     baukis/admin/sessions#create
#         baukis_admin_staff_member_staff_events GET    /baukis/admin/staff_members/:staff_member_id/staff_events(.:format) baukis/admin/staff_events#index
#                     baukis_admin_staff_members GET    /baukis/admin/staff_members(.:format)                               baukis/admin/staff_members#index
#                                                POST   /baukis/admin/staff_members(.:format)                               baukis/admin/staff_members#create
#                  new_baukis_admin_staff_member GET    /baukis/admin/staff_members/new(.:format)                           baukis/admin/staff_members#new
#                 edit_baukis_admin_staff_member GET    /baukis/admin/staff_members/:id/edit(.:format)                      baukis/admin/staff_members#edit
#                      baukis_admin_staff_member GET    /baukis/admin/staff_members/:id(.:format)                           baukis/admin/staff_members#show
#                                                PATCH  /baukis/admin/staff_members/:id(.:format)                           baukis/admin/staff_members#update
#                                                PUT    /baukis/admin/staff_members/:id(.:format)                           baukis/admin/staff_members#update
#                                                DELETE /baukis/admin/staff_members/:id(.:format)                           baukis/admin/staff_members#destroy
#                      baukis_admin_staff_events GET    /baukis/admin/staff_events(.:format)                                baukis/admin/staff_events#index
#            delete_baukis_admin_allowed_sources DELETE /baukis/admin/allowed_sources/delete(.:format)                      baukis/admin/allowed_sources#delete
#                   baukis_admin_allowed_sources GET    /baukis/admin/allowed_sources(.:format)                             baukis/admin/allowed_sources#index
#                                                POST   /baukis/admin/allowed_sources(.:format)                             baukis/admin/allowed_sources#create
#                           baukis_customer_root GET    /baukis/customer(.:format)                                          baukis/customer/top#index
#                          baukis_customer_login GET    /baukis/customer/login(.:format)                                    baukis/customer/sessions#new
#                        baukis_customer_session DELETE /baukis/customer/session(.:format)                                  baukis/customer/sessions#destroy
#                                                POST   /baukis/customer/session(.:format)                                  baukis/customer/sessions#create
#                confirm_baukis_customer_account PATCH  /baukis/customer/account/confirm(.:format)                          baukis/customer/accounts#confirm
#                   edit_baukis_customer_account GET    /baukis/customer/account/edit(.:format)                             baukis/customer/accounts#edit
#                        baukis_customer_account GET    /baukis/customer/account(.:format)                                  baukis/customer/accounts#show
#                                                PATCH  /baukis/customer/account(.:format)                                  baukis/customer/accounts#update
#                                                PUT    /baukis/customer/account(.:format)                                  baukis/customer/accounts#update
#           cancel_baukis_customer_program_entry PATCH  /baukis/customer/programs/:program_id/entries/:id/cancel(.:format)  baukis/customer/entries#cancel
#                baukis_customer_program_entries POST   /baukis/customer/programs/:program_id/entries(.:format)             baukis/customer/entries#create
#                       baukis_customer_programs GET    /baukis/customer/programs(.:format)                                 baukis/customer/programs#index
#                        baukis_customer_program GET    /baukis/customer/programs/:id(.:format)                             baukis/customer/programs#show
#               confirm_baukis_customer_messages POST   /baukis/customer/messages/confirm(.:format)                         baukis/customer/messages#confirm
#          confirm_baukis_customer_message_reply POST   /baukis/customer/messages/:message_id/reply/confirm(.:format)       baukis/customer/replies#confirm
#              new_baukis_customer_message_reply GET    /baukis/customer/messages/:message_id/reply/new(.:format)           baukis/customer/replies#new
#                  baukis_customer_message_reply POST   /baukis/customer/messages/:message_id/reply(.:format)               baukis/customer/replies#create
#                       baukis_customer_messages GET    /baukis/customer/messages(.:format)                                 baukis/customer/messages#index
#                                                POST   /baukis/customer/messages(.:format)                                 baukis/customer/messages#create
#                    new_baukis_customer_message GET    /baukis/customer/messages/new(.:format)                             baukis/customer/messages#new
#                        baukis_customer_message GET    /baukis/customer/messages/:id(.:format)                             baukis/customer/messages#show
#                                                DELETE /baukis/customer/messages/:id(.:format)                             baukis/customer/messages#destroy
#                                    baukis_root GET    /baukis(.:format)                                                   baukis/errors#routing_error
#                                         baukis GET    /baukis/*anything(.:format)                                         baukis/errors#routing_error
#                            awesome_events_root GET    /awesome_events(.:format)                                           awesome_events/welcome#index
#                   awesome_events_welcome_index GET    /awesome_events/welcome(.:format)                                   awesome_events/welcome#index
#                          awesome_events_logout GET    /awesome_events/logout(.:format)                                    awesome_events/sessions#destroy
#                     retire_awesome_events_user GET    /awesome_events/user/retire(.:format)                               awesome_events/users#retire
#                            awesome_events_user DELETE /awesome_events/user(.:format)                                      awesome_events/users#destroy
#                   awesome_events_event_tickets POST   /awesome_events/events/:event_id/tickets(.:format)                  awesome_events/tickets#create
#                new_awesome_events_event_ticket GET    /awesome_events/events/:event_id/tickets/new(.:format)              awesome_events/tickets#new
#                    awesome_events_event_ticket DELETE /awesome_events/events/:event_id/tickets/:id(.:format)              awesome_events/tickets#destroy
#                          awesome_events_events POST   /awesome_events/events(.:format)                                    awesome_events/events#create
#                       new_awesome_events_event GET    /awesome_events/events/new(.:format)                                awesome_events/events#new
#                      edit_awesome_events_event GET    /awesome_events/events/:id/edit(.:format)                           awesome_events/events#edit
#                           awesome_events_event GET    /awesome_events/events/:id(.:format)                                awesome_events/events#show
#                                                PATCH  /awesome_events/events/:id(.:format)                                awesome_events/events#update
#                                                PUT    /awesome_events/events/:id(.:format)                                awesome_events/events#update
#                                                DELETE /awesome_events/events/:id(.:format)                                awesome_events/events#destroy
#                                 awesome_events        /awesome_events/*path(.:format)                                     awesome_events/application#error404
#                                                GET    /auth/:provider/callback(.:format)                                  awesome_events/sessions#create
#                                     todo_tasks GET    /todo/tasks(.:format)                                               todo/tasks#index
#                                                POST   /todo/tasks(.:format)                                               todo/tasks#create
#                                  new_todo_task GET    /todo/tasks/new(.:format)                                           todo/tasks#new
#                                 edit_todo_task GET    /todo/tasks/:id/edit(.:format)                                      todo/tasks#edit
#                                      todo_task GET    /todo/tasks/:id(.:format)                                           todo/tasks#show
#                                                PATCH  /todo/tasks/:id(.:format)                                           todo/tasks#update
#                                                PUT    /todo/tasks/:id(.:format)                                           todo/tasks#update
#                                                DELETE /todo/tasks/:id(.:format)                                           todo/tasks#destroy
#                                            kss        /kss                                                                Kss::Engine
#                           css_design_top_index GET    /css_design/top(.:format)                                           css_design/top#index
#                             css_design_chap2_2 GET    /css_design/chap2_2(.:format)                                       css_design/top#chap2_2
#                             css_design_chap4_1 GET    /css_design/chap4_1(.:format)                                       css_design/top#chap4_1
#                             css_design_chap4_2 GET    /css_design/chap4_2(.:format)                                       css_design/top#chap4_2
#                             css_design_chap5_1 GET    /css_design/chap5_1(.:format)                                       css_design/top#chap5_1
#                             css_design_chap7_2 GET    /css_design/chap7_2(.:format)                                       css_design/top#chap7_2
#                            sass_base_top_index GET    /sass_base/top(.:format)                                            sass_base/top#index
#                                sass_base_chap3 GET    /sass_base/chap3(.:format)                                          sass_base/top#chap3
#                                sass_base_chap4 GET    /sass_base/chap4(.:format)                                          sass_base/top#chap4
#                             css_base_top_index GET    /css_base/top(.:format)                                             css_base/top#index
#                       css_base_chapter04_index GET    /css_base/chapter04(.:format)                                       css_base/chapter04#index
#                       css_base_chapter05_index GET    /css_base/chapter05(.:format)                                       css_base/chapter05#index
#                       css_base_chapter06_index GET    /css_base/chapter06(.:format)                                       css_base/chapter06#index
#                       css_base_chapter07_index GET    /css_base/chapter07(.:format)                                       css_base/chapter07#index
#                       css_base_chapter08_index GET    /css_base/chapter08(.:format)                                       css_base/chapter08#index
#                css_base_chapter10_sample_10_01 GET    /css_base/chapter10/sample_10_01(.:format)                          css_base/chapter10#sample_10_01
#                          css_base_chapter10_02 GET    /css_base/chapter10_02/index(.:format)                              css_base/chapter10#sample_10_02
#                    point_css_base_chapter10_02 GET    /css_base/chapter10_02/point(.:format)                              css_base/chapter10#sample_10_02_point
#                   course_css_base_chapter10_02 GET    /css_base/chapter10_02/course(.:format)                             css_base/chapter10#sample_10_02_course
#                    trial_css_base_chapter10_02 GET    /css_base/chapter10_02/trial(.:format)                              css_base/chapter10#sample_10_02_trial
#                   access_css_base_chapter10_02 GET    /css_base/chapter10_02/access(.:format)                             css_base/chapter10#sample_10_02_access
#                  contact_css_base_chapter10_02 GET    /css_base/chapter10_02/contact(.:format)                            css_base/chapter10#sample_10_02_contact
#                          css_base_chapter10_03 GET    /css_base/chapter10_03/index(.:format)                              css_base/chapter10#sample_10_03
#                    about_css_base_chapter10_03 GET    /css_base/chapter10_03/about(.:format)                              css_base/chapter10#sample_10_03_about
#                  service_css_base_chapter10_03 GET    /css_base/chapter10_03/service(.:format)                            css_base/chapter10#sample_10_03_service
#                  contact_css_base_chapter10_03 GET    /css_base/chapter10_03/contact(.:format)                            css_base/chapter10#sample_10_03_contact
#                     blog_css_base_chapter10_03 GET    /css_base/chapter10_03/blog(.:format)                               css_base/chapter10#sample_10_03_blog
#                          javascripts_top_index GET    /javascripts/top(.:format)                                          javascripts/top#index
#                  javascripts_samples_sample_01 GET    /javascripts/samples/sample_01(.:format)                            javascripts/samples#sample_01
#                  javascripts_samples_sample_02 GET    /javascripts/samples/sample_02(.:format)                            javascripts/samples#sample_02
#                  javascripts_samples_sample_03 GET    /javascripts/samples/sample_03(.:format)                            javascripts/samples#sample_03
#                  javascripts_samples_sample_04 GET    /javascripts/samples/sample_04(.:format)                            javascripts/samples#sample_04
#                  javascripts_samples_sample_05 GET    /javascripts/samples/sample_05(.:format)                            javascripts/samples#sample_05
#                  javascripts_samples_sample_06 GET    /javascripts/samples/sample_06(.:format)                            javascripts/samples#sample_06
#                  javascripts_samples_sample_07 GET    /javascripts/samples/sample_07(.:format)                            javascripts/samples#sample_07
#                  javascripts_samples_sample_08 GET    /javascripts/samples/sample_08(.:format)                            javascripts/samples#sample_08
#                     bootstraps_dashboard_index GET    /bootstraps/dashboard(.:format)                                     bootstraps/dashboard#index
#                        bootstraps_layout_index GET    /bootstraps/layout(.:format)                                        bootstraps/layout#index
#                          bootstraps_form_index GET    /bootstraps/form(.:format)                                          bootstraps/form#index
#                            bootstraps_ui_index GET    /bootstraps/ui(.:format)                                            bootstraps/ui#index
#                   bootstraps_java_script_index GET    /bootstraps/java_script(.:format)                                   bootstraps/java_script#index
#                         bootstraps_affix_index GET    /bootstraps/affix(.:format)                                         bootstraps/affix#index
#                      html_css_book_index_index GET    /html_css_book/index(.:format)                                      html_css_book/index#index
#                  html_css_book_campaign_submit GET    /html_css_book/campaign/:campaign_id/submit(.:format)               html_css_book/campaign#submit
#                   html_css_book_campaign_index GET    /html_css_book/campaign(.:format)                                   html_css_book/campaign#index
#                    html_css_book_article_index GET    /html_css_book/article(.:format)                                    html_css_book/article#index
#              react_beginners_guide_excel_index GET    /react_beginners_guide/excel(.:format)                              react_beginners_guide/excel#index
# discovery_react_beginners_guide_whinepad_index GET    /react_beginners_guide/whinepad/discovery(.:format)                 react_beginners_guide/whinepad#discovery
#           react_beginners_guide_whinepad_index GET    /react_beginners_guide/whinepad(.:format)                           react_beginners_guide/whinepad#index
#           intro_to_reacts_intro_to_react_index GET    /intro_to_reacts/intro_to_react(.:format)                           intro_to_reacts/intro_to_react#index
#                     beer_lists_beer_list_index GET    /beer_lists/beer_list(.:format)                                     beer_lists/beer_list#index
#                                           root GET    /                                                                   home#index
#
# Routes for Kss::Engine:
# styleguide GET  /styleguide(.:format) kss/home#styleguide
#       root GET  /                     kss/home#index
#

Rails.application.routes.draw do
  namespace :rails_tutorial do
    root 'application#hello'

    namespace :toy do
      resources :microposts
      resources :users
      root 'users#index'
    end

    namespace :sample do
      root 'static_pages#home'
      get '/help', to:'static_pages#help'
      get '/about', to:'static_pages#about'
      get '/contact', to:'static_pages#contact'
      get '/signup', to:'users#new'
      post '/signup',  to: 'users#create'
      get    '/login',   to: 'sessions#new'
      post   '/login',   to: 'sessions#create'
      delete '/logout',  to: 'sessions#destroy'
      resources :users do
        member do
          get :following, :followers
        end
      end
      resources :users
      resources :account_activations, only:[:edit]
      resources :password_resets, only:[:new,:create,:edit,:update]
      resources :microposts, only:[:create, :destroy]
      resources :relationships,       only: [:create, :destroy]
    end
  end

  namespace :baukis do
    namespace :staff, path: '' do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resource :session, only:[ :create, :destroy ]
      resource :account, except: [ :new, :create, :destroy ] do
        patch :confirm
      end
      resource :password, only: [ :show, :edit, :update ]
      resources :customers
      resources :programs do
        patch :entries, on: :member
      end
      resources :messages, only: [ :index, :show, :destroy ] do
        get :inbound, :outbound, :deleted, :count, on: :collection
        post :tag, on: :member
        delete :tag, on: :member
        resource :reply, only: [ :new, :create ] do
          post :confirm
        end
      end
      resources :tags, only: [] do
        resources :messages, only: [ :index ] do
          get :inbound, :outbound, :deleted, on: :collection
        end
      end
    end

    namespace :admin do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resource :session, only:[ :create, :destroy ]
      resources :staff_members do
        resources :staff_events, only: [ :index ]
      end
      resources :staff_events, only: [ :index ]
      # resources :staff_members, only: [ :index, :new, :create ]
      # resources :staff_members, except: [ :show, :destroy ]
      # resources :staff_members, controller: 'employees' do
      # resources :staff_members, path: 'staff'
      resources :allowed_sources, only: [ :index, :create ] do
        delete :delete, on: :collection
      end
    end

    namespace :customer do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resource :session, only: [ :create, :destroy ]
      resource :account, except: [ :new, :create, :destroy ] do
        patch :confirm
      end
      resources :programs, only: [ :index, :show ] do
        resources :entries, only: [ :create ] do
          patch :cancel, on: :member
        end
      end
      resources :messages, except: [ :edit, :update ] do
        post :confirm, on: :collection
        resource :reply, only: [ :new, :create ] do
          post :confirm
        end
      end
    end

    root 'errors#routing_error'
    get '*anything' => 'errors#routing_error'
  end

  namespace :awesome_events do
    root 'welcome#index'
    resources :welcome, only:[:index]
    get '/logout' => 'sessions#destroy', as: :logout

    resource :user, only: :destroy do
      get 'retire'
    end

    resources :events, except: :index do
      resources :tickets, only: [:new, :create, :destroy]
    end
    match '*path' => 'application#error404', via: :all
  end
  get 'auth/:provider/callback' =>'awesome_events/sessions#create'

  namespace :todo do
    resources :tasks
  end
  mount Kss::Engine => '/kss' if Rails.env.development?
  namespace :css_design do
    resources :top, only:[:index]
    get 'chap2_2', to: 'top#chap2_2'
    get 'chap4_1', to: 'top#chap4_1'
    get 'chap4_2', to: 'top#chap4_2'
    get 'chap5_1', to: 'top#chap5_1'
    get 'chap7_2', to: 'top#chap7_2'
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

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
