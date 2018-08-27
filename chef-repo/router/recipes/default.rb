#
# Cookbook:: router
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

execute 'ip_forward' do
  command '/etc/network/if-up.d/iptables'
  action :nothing
end

template '/etc/network/if-up.d/iptables' do
  source 'iptables'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :run, 'execute[ip_forward]', :immediately
end
