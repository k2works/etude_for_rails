role :app, %w(127.0.0.1)
role :db,  %w(127.0.0.1)
role :web, %w(127.0.0.1)

set(
    :ssh_options,
    port: 2222,
    auth_methods: %w(publickey),
    keys: [File.expand_path("../../../ops/01_development/.vagrant/machines/default/virtualbox/private_key", __FILE__)],
    user: "vagrant"
)
set :rails_env, :development
set :bundle_without, []
# capistrano-scm-copyの設定
set :scm, :copy
set :include_dir, ["*", '.ruby-version', '.postcssrc.yml']
set :exclude_dir, ['vendor/bundle', 'log\/*', 'tmp\/*', 'mydb\/*', 'public\/*', 'node_modules\/*', 'ops\/*']
set :db_name, 'etude_for_rails_development'