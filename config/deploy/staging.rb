role :app, %w(52.70.54.183)
role :db,  %w(52.70.54.183)
role :web, %w(52.70.54.183)

set(
    :ssh_options,
    port: 22,
    auth_methods: %w(publickey),
    keys: [File.expand_path("../../../ops/02_staging/config/secure/stg-app.pem", __FILE__)],
    user: "ec2-user"
)
set :rails_env, :staging
set :branch, 'develop'
set :bundle_without, []
# capistrano-scm-copyの設定
#set :scm, :copy
#set :include_dir, ["*", '.ruby-version', '.postcssrc.yml', '.env.development']
#set :exclude_dir, ['vendor/bundle', 'log\/*', 'tmp\/*', 'mydb\/*', 'public\/*', 'node_modules\/*', 'ops\/*']
#set :linked_dirs, %w(node_modules public/packs)
set :db_name, 'etude_for_rails_staging'

#Whenever
set :whenever_environment, "#{fetch(:stage)}"
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

SSHKit.config.command_map[:whenever] = "bundle exec whenever"
