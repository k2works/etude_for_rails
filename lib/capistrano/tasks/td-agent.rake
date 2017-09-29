namespace :td_agent do
  desc 'Initial Setup'
  task init: [:setup_plugin, :config_upload, :restart_service]

  desc 'Setup plugin'
  task :setup_plugin do
    on roles(:app) do
      execute :sudo, "/opt/td-agent/embedded/bin/gem install elasticsearch"
      execute :sudo, "/opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-parser"
      execute :sudo, "/opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-record-reformer"
    end
  end

  desc 'Upload config file'
  task :config_upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/td-agent.conf', "#{shared_path}/config/td-agent.conf")
      execute :sudo, "cp /var/app/shared/config/td-agent.conf /etc/td-agent/td-agent.conf"
      execute :sudo, "systemctl daemon-reload"
    end
  end

  desc 'Start td-agent service'
  task :start_service do
    on roles(:app) do
      execute :sudo, "systemctl start td-agent"
    end
  end

  desc 'Stop td-agent service'
  task :stop_service do
    on roles(:app) do
      execute :sudo, "systemctl stop td-agent"
    end
  end

  desc 'ReStart td-agent service'
  task :restart_service do
    on roles(:app) do
      execute :sudo, "systemctl restart td-agent"
    end
  end
end
