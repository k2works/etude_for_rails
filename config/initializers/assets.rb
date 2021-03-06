# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w(rails_tutorial.css rails_tutorial.js baukis_customer.css baukis_customer.js baukis_admin.css baukis_admin.js baukis_staff.css baukis_staff.js kss.css blackboard.css kss.js rainbow.js)

Sprockets::Context.send(:include, Rails.application.routes.url_helpers)