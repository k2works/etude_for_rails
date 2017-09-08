# config valid only for current version of Capistrano
lock '3.9.0'

set :repo_url, 'https://github.com/k2works/etude_for_rails.git'
set :application, "app"
set :deploy_to, "/var/#{fetch(:application)}"
set :keep_releases, 5
set :log_level, :info

set :bundle_without, %i(development test)

set :puma_threds,  [4, 16]
set :puma_workers, 0
set :pty, true
set :rbenv_ruby, '2.4.1'

# 必要に応じて、gitignoreしているファイルにLinkを貼る
#set :linked_files, fetch(:linked_files, []).push('config/secrets.yml')

set :use_sudo, false
set :stage, :production
set :deploy_via, :remote_cache

# deploy先サーバにおく場所
set :deploy_to, "/var/#{fetch(:application)}"

set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub), port: 22 }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

set :keep_releases, 2

desc 'Upload database.yml'
task :upload do
  on roles(:app) do |host|
    if test "[ ! -d #{shared_path}/config ]"
      execute "mkdir -p #{shared_path}/config"
    end
    upload!('config/database.yml', "#{shared_path}/config/database.yml")
  end
end

desc 'Create Database'
task :db_create do
  on roles(:db) do |host|
    with rails_env: fetch(:rails_env) do
      within current_path do
        execute :bundle, :exec, :rake, 'db:create'
      end
    end
  end
end

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
      execute "mkdir #{shared_path}/log -p"
    end
  end

  task :start_service do
    on roles(:app) do
      unless test "[ -f #{shared_path.join('tmp', 'pids', 'puma.pid')} ]"
        execute :sudo, :systemctl, :start, :puma
      end
    end
  end

  task :stop_service do
    on roles(:app) do
      execute :sudo, :systemctl, :stop, :puma
    end
  end

  before :start_service, :make_dirs
  before :start, :make_dirs
  before :start, :stop_service
  before :stop,  :stop_service
  before :restart, :stop_service
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:production) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end