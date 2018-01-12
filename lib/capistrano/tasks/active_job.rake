namespace :active_job do
  desc 'Create Directories for Pids'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/pids -p"
      execute "mkdir #{shared_path}/log -p"
    end
  end

  desc 'Upload config'
  task :config_upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/sidekiq.yml', "#{shared_path}/config/sidekiq.yml")
    end
  end

  desc 'Start ActiveJob Service'
  task :start do
    on roles(:app) do
      execute :sudo, :service, :active_job, :start
    end
  end

  desc 'Stop ActiveJob Service'
  task :stop do
    on roles(:app) do
      execute :sudo, :service, :active_job, :stop
    end
  end

  desc 'Restart ActiveJob Service'
  task :restart do
    on roles(:app) do
      execute :sudo, :service, :active_job, :restart
    end
  end

  before :start, :make_dirs
  after  :make_dirs, :config_upload
end
