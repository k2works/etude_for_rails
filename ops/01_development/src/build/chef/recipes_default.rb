#
# Cookbook Name:: chef
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
include_recipe 'ruby_platform::setup'
include_recipe 'ruby_platform::setup_ruby'
include_recipe 'ruby_platform::setup_node'
include_recipe 'ruby_platform::setup_mysql'
include_recipe 'ruby_platform::setup_postgres'
include_recipe 'ruby_platform::setup_redis'
include_recipe 'ruby_platform::setup_mongodb'
include_recipe 'ruby_platform::setup_nginx'
include_recipe 'ruby_platform::setup_service'
include_recipe 'ruby_platform::configure'
