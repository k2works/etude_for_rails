# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'
require 'capistrano/safe_deploy_to'
require 'capistrano/copy'
require 'capistrano/rails'
require 'capistrano/rbenv'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/bundler'
require 'capistrano/maintenance'
require 'whenever/capistrano'
require 'capistrano/puma'
install_plugin Capistrano::Puma
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

#Rake::Task[:development].invoke
#invoke :development
