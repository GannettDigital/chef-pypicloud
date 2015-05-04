default['pypicloud']['user'] = 'pypi'
default['pypicloud']['group'] = 'pypi'
default['pypicloud']['version'] = nil
default['pypicloud']['installdir'] = '/opt/pypi'
default['pypicloud']['storage']['type'] = 'file'
default['pypicloud']['storage']['filedir'] = '/var/cache/pypi'
default['pypicloud']['cachedb']['type'] = ''
default['pypicloud']['cachedb']['url'] = ''

default['pypicloud']['allow-overwrite'] = 'True'
default['pypicloud']['default-read'] = 'everyone'
default['pypicloud']['default-write'] = 'authenticated'
default['pypicloud']['auth']['admins'] = 'administrator'

default['pypicloud']['site-name'] = 'pypi'

default['pypicloud']['uwsgi']['emperor'] = '/etc/uwsgi/siteconf'
default['pypicloud']['uwsgi']['workers'] = '2'
default['pypicloud']['uwsgi']['uid'] = 'nobody'

default['pypicloud']['ssl-enabled'] = false
default['pypicloud']['sslcert-path'] = '/etc/ssl/certs'
default['pypicloud']['ssl-name'] = 'pypicloud-cert'
default['pypicloud']['data_bag'] = 'pypicloud'
default['pypicloud']['ssl_protocols'] = 'TLSv1 TLSv1.1 TLSv1.2'
default['pypicloud']['ssl_ciphers'] = 'HIGH:!aNULL:!MD5'

default['nginx']['uwsgi_read_timeout'] = 90
default['nginx']['uwsgi_send_timeout'] = 90
default['uwsgi']['harakiri'] = 60
default['uwsgi']['fastrouter-timeout'] = 180
default['uwsgi']['fastrouter-harakiri'] = 120
default['uwsgi']['workers'] = 10
default['uwsgi']['threads'] = 5
default['uwsgi']['cheap'] = true
default['uwsgi']['cheaper'] = 1
default['uwsgi']['cheaper-initial'] = 2
default['uwsgi']['listen-queue'] = 1024
default['uwsgi']['use_fastrouter'] = true
