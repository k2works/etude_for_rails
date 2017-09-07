mysql_password = node['mysql']['password']
dbuser = node['mysql']['db']['user']
password = node['mysql']['db']['pass']
database = node['mysql']['db']['database']


mysql_service 'default' do
  port '3306'
  version node['mysql']['version']
  initial_root_password node['mysql']['server_root_password']
  action [:create, :start]
end

mysql_config 'default' do
  source 'my_extra_settings.erb'
  notifies :restart, 'mysql_service[default]'
  action :create
end

# https://mistymagich.wordpress.com/2013/10/08/db%E3%81%8C%E5%AD%98%E5%9C%A8%E3%81%97%E3%81%AA%E3%81%84%E3%81%A8%E3%81%8D%E3%81%ABdb%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8Bchef%E3%83%AC%E3%82%B7%E3%83%94%E3%82%92%E4%BD%9C%E3%81%A3%E3%81%9F/
execute "mysql-create-user" do
  command "/usr/bin/mysql -u root -h127.0.0.1 --password=\"#{mysql_password}\"  < /tmp/grants.sql"
  action :nothing
end

template "grants.sql" do
  source "grants.sql.erb"
  path "/tmp/grants.sql"
  owner "root"
  group "root"
  mode "0600"
  variables(
      :user     => dbuser,
      :password => password,
      :database => database
  )
  notifies :run, "execute[mysql-create-user]", :immediately
end
