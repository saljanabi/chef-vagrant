#
# Cookbook:: proxyconf
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
execute 'enable_devops' do
  command 'nxensite devops'
  action :nothing
end

execute 'delete_default' do
  command 'rm /etc/nginx/sites-available/default'
  action :nothing
end

service 'nginx' do
  supports :status => true, :restart => true, :reload => true
end

template '/etc/nginx/sites-available/devops' do
  source 'devops'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :run, 'execute[enable_devops]', :immediately
  notifies :run, 'execute[delete_default]', :immediately
  notifies :reload, 'service[nginx]', :immediately
end
