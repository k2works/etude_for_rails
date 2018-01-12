role :app, %w(127.0.0.1)
role :db,  %w(127.0.0.1)
role :web, %w(127.0.0.1)

set(
    :ssh_options,
    port: 2201,
    auth_methods: %w(publickey),
    keys: [File.expand_path("~/.vagrant.d/insecure_private_key", __FILE__)],
    user: "vagrant"
)
set :rails_env, :development
set :branch, 'develop'
set :bundle_without, []
# capistrano-scm-copyの設定
set :scm, :copy
set :include_dir, ["*", '.ruby-version', '.postcssrc.yml', '.env.development']
set :exclude_dir, ['vendor/bundler', 'log\/*', 'tmp\/*', 'mydb\/*', 'public\/*', 'node_modules\/*', 'ops\/*']
set :linked_dirs, %w(node_modules public/packs)
set :db_name, 'etude_for_rails_development'

#Whenever
set :whenever_environment, "#{fetch(:stage)}"
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

SSHKit.config.command_map[:whenever] = "bundle exec whenever"
