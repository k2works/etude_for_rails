# 開発環境

# 前提

# 構成
+ 概要
+ 構築
+ 配置
+ 運用

# 詳細
## 概要


## 構築
### インフラのセットアップ

```bash
cd ops/01_development
vagrant up
vagrant ssh
```

```bash
cd /vagrant
./src/build/sh/build.sh
source ~/.bash_profile
exit
vagrant reload
```

### アプリケーションのセットアップ
```bash
sudo gem install bundler
sudo gem install rails
rails new . -d mysql
```

## 配置
### アプリケーションのデプロイ

```ruby:Gemfile
# Use Capistrano for deployment
group :development do
  gem 'capistrano', '~> 3.3.0'
  gem 'capistrano-scm-copy'
  gem 'capistrano-safe-deploy-to', '~> 1.1.1'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
end
```

```bash
bundle
bundle exec cap install STAGES=development
```

```ruby:Capfile
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

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
```

```ruby:config/deploy/development.rb
role :server, %w(127.0.0.1)
set(
    :ssh_options,
    port: 2222,
    auth_methods: %w(publickey),
    keys: [File.expand_path("../../../../ops/01_development/.vagrant/machines/default/virtualbox/private_key", __FILE__)],
    user: "vagrant"
)
```

```ruby:config/deploy.rb
# config valid only for current version of Capistrano
lock '3.3.5'

set :application, "app"
set :deploy_to, "/var/app"
set :keep_releases, 5
set :log_level, :info

set :bundle_without, %i(development test)

# capistrano-scm-copyの設定
set :scm, :copy
```

```bash
bundle exec cap development deploy
```

### アプリケーション・サーバー仮想マシンへのログイン


## 運用
### データのバックアップ
### 環境の廃棄


# 参照
+ [rails5 + puma + nginx で AWSテスト環境を構築してみる](http://sodex.hatenablog.com/entry/2017/02/05/141803)
+ [Capistrano 3系でRails 4.1のデプロイ[rbenv][rvm][ruby2.1]](http://morizyun.github.io/blog/capistrano3-rails-deploy-multi-rbenv/index.html)
+ [How To Install Nginx On Ubuntu Using Chef](http://www.swiftsoftwaregroup.com/install-nginx-ubuntu-using-chef)
+ [Rails pumaをsystemdで動かす](http://morizyun.github.io/ruby/rails-tips-puma-systemd.html)
