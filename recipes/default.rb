# My provisioner node has ChefDK installed which already has the
# chef-vault and fog gems installed.
#
# include_recipe 'chef-vault'
# include_recipe 'dnsimple'

require 'fog'

dnsimple       = chef_vault_item('secrets', 'dnsimple')['data']
analytics_fqdn = search(:node, 'name:analytics').first['ec2']['public_hostname']
frontend_fqdn  = search(:node, 'name:frontend').first['ec2']['public_hostname']

dnsimple_record "analytics.#{dnsimple['domain']}" do
  name 'analytics'
  content analytics_fqdn
  type 'CNAME'
  ttl 60
  username dnsimple['username']
  password dnsimple['password']
  domain dnsimple['domain']
  action :create
end

dnsimple_record "chef.#{dnsimple['domain']}" do
  name 'chef'
  content frontend_fqdn
  type 'CNAME'
  ttl 60
  username dnsimple['username']
  password dnsimple['password']
  domain dnsimple['domain']
  action :create
end
