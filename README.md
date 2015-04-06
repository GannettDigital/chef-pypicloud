pypicloud Cookbook
==================

Installs and configures pypicloud

Requirements
------------
### Cookbooks
- python
- nginx
- uwsgi
- redisio

Attributes
----------
See `attributes/default.rb` for node values.

- node['pypicloud']['version'] = nil
  Version of pypicloud to install, defaults to latest
- node['pypicloud']['installdir']
  Location for installing pypicloud virtual environment, defaults to '/opt/pypi'
- node['pypicloud']['storage']['type'] = 'file'
  Storage type for where to store local artifacts
  - Options:
    - file: local filesystem storage
    - s3: Amazon S3 backed storage (bucket name and credentials stored in data bag)
- node['pypicloud']['storage']['filedir']
  Location for file based storage of artifacts, defaults to '/var/cache/pypi'
- node['pypicloud']['cachedb']['type']
  Database type for caching backend.
  - Options: 
    SQLAlchemy: Leave empty or 'sql'
    Redis: 'redis'
- node['pypicloud']['cachedb']['url']
  The database url to use for the caching database.
  - Examples:
    SQLAlchemy: Leave blank for SQLLite.  Refer to http://docs.sqlalchemy.org/en/rel_0_9/core/engines.html for other options
    Redis: The format looks like this: redis://username:password@localhost:6379/0
- node['pypicloud']['allow-overwrite']
  Allow users to upload packages that will overwrite an existing version, default 'True'
- node['pypicloud']['node-read']
  List of groups that are allowed to read packages that have no explicit user or group permissions, default 'everyone'
- node['pypicloud']['node-write']
  List of groups that are allowed to write packages that have no explicit user or group permissions , default 'authenticated'
- node['pypicloud']['auth']['admins']
  pypicloud admin user list (delimited by spaces), defaults to 'administrator'
- node['pypicloud']['site-name']
  Nginx site name, defaults to 'pypi'


### To Do
---------
- User/group auth management
- DynamoDB support
- Additional pypicloud config overrides
