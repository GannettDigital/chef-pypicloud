# -*- encoding: utf-8 -*-
source 'https://rubygems.org'

gem 'berkshelf'
gem 'coveralls', require: false
gem 'rubocop'
gem 'webmock'

group :test do
  gem 'rubocop-checkstyle_formatter', require: false
  gem 'chefspec', '~> 4.2'
  gem 'foodcritic', '~> 4.0.0'
  gem 'rake', '>= 10.2'
end

group :integration do
  gem 'guard', '>= 2.6'
  gem 'guard-foodcritic', '~> 1.0.3'
  gem 'guard-kitchen'
  gem 'guard-rspec'
  gem 'guard-rubocop', '>= 1.1'
  gem 'kitchen-vagrant'
  gem 'test-kitchen', '~> 1.2.0'
  gem 'travis-lint'
end
