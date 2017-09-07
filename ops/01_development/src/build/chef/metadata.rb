name 'ruby_platform'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures chef'
long_description 'Installs/Configures chef'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/chef/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/chef'

depends 'apt',    '2.9.2'
depends 'git', '~> 5.0.1'
depends 'poise', '~> 2.8.1'
depends 'application_ruby', '~> 4.0.1'
depends 'poise-ruby-build'
depends 'mysql',  '~> 8.2.0'
depends 'postgresql', '~> 6.0.1'
depends 'build-essential', '~> 7.0.1'
depends 'redis', '~> 3.0.4'
depends 'mongodb', '~> 0.16.2'
depends 'nodejs', '~> 2.4.4'
depends 'nvm', '~> 0.1.7'
depends 'nginx', '~> 1.8.0'
