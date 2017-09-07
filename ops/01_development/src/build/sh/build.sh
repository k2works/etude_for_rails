#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y install curl
curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 1.6.1
cd /vagrant
sudo chef generate cookbook build
cd build
cp ../src/build/chef/provision.json .
cp ../src/build/chef/metadata.rb .
cp ../src/build/chef/recipes_default.rb recipes/default.rb
cp ../src/build/chef/recipes_setup.rb recipes/setup.rb
cp ../src/build/chef/recipes_setup_ruby.rb recipes/setup_ruby.rb
cp ../src/build/chef/recipes_setup_mysql.rb recipes/setup_mysql.rb
cp ../src/build/chef/recipes_setup_postgres.rb recipes/setup_postgres.rb
cp ../src/build/chef/recipes_setup_redis.rb recipes/setup_redis.rb
cp ../src/build/chef/recipes_setup_mongodb.rb recipes/setup_mongodb.rb
cp ../src/build/chef/recipes_setup_node.rb recipes/setup_node.rb
cp ../src/build/chef/recipes_setup_nginx.rb recipes/setup_nginx.rb
cp ../src/build/chef/recipes_setup_service.rb recipes/setup_service.rb
cp ../src/build/chef/recipes_configure.rb recipes/configure.rb
chef generate attribute default
cp ../src/build/chef/attributes_default.rb attributes/default.rb
chef generate template default
cp ../src/build/chef/templates_default_banner.erb templates/default/banner.erb
cp ../src/build/chef/templates_default_bash_profile.erb templates/default/.bash_profile.erb
cp ../src/build/chef/templates_default_grants.sql.erb templates/default/grants.sql.erb
cp ../src/build/chef/templates_default_my_extra_settings.erb templates/default/my_extra_settings.erb
cp ../src/build/chef/templates_default_nginx.default.conf.erb templates/default/nginx.default.conf.erb
cp ../src/build/chef/templates_default_nginx.proxy.conf.erb templates/default/nginx.proxy.conf.erb
cp ../src/build/chef/templates_default_puma.erb templates/default/puma.erb
cp ../src/build/chef/templates_default_puma.service.erb templates/default/puma.service.erb
berks vendor cookbooks
sudo chef-client -z -j provision.json
