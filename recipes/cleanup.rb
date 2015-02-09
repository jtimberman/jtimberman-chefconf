require 'fog'

dnsimple = chef_vault_item('secrets', 'dnsimple')['data']

%w(chef analytics).each do |host|

  dnsimple_record "#{host}.#{dnsimple['domain']}" do
    username dnsimple['username']
    password dnsimple['password']
    domain dnsimple['domain']
    action :delete
  end

end
