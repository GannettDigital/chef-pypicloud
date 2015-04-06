name             'pypicloud'
maintainer       'Gannett'
maintainer_email 'jneves@gannett.com'
license          'All rights reserved'
description      'Installs/Configures pypicloud'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'nginx'
depends 'uwsgi'
depends 'python'
depends 'redisio'
