# Don't use 'source :rubygems'; it's insecure from man-in-the-middle attacks.
source 'https://rubygems.org'

#  Mongoid 3 requires Ruby 1.9.3, per http://mongoid.org/en/mongoid/index.html
ruby '1.9.3'

#  Gems normally needed by Rails:

gem 'bundler',      '~> 1.3.0.pre',   '>= 1.3.0.pre.7'
gem 'jquery-rails', '~> 2.2',   '>= 2.2.0'
#    rack ~> 1.4.0 is necessary, for Rails 3.2.11.
gem 'rack',         '~> 1.4.0',   '>= 1.4.4'
#  Include Rails 3.2.11 security update:
gem 'rails',        ' = 3.2.11'
gem 'rake',         '~> 10.0',  '>= 10.0.3'

#  (End of gems needed normally by Rails.)

gem 'cancan',            '~> 1.6',  '>= 1.6.9'
gem 'figaro',            '~> 0.5',  '>= 0.5.3'
gem 'mongoid',           '~> 3.0',  '>= 3.0.21'
#  gem 'omniauth' automatically pulled in by omniauth-facebook.
gem 'omniauth-facebook', '~> 1.4',  '>= 1.4.1'
gem 'rolify',            '~> 3.2',  '>= 3.2.0'
gem 'simple_form',       '~> 2.0',  '>= 2.0.4'

#  Gems used only for assets and not needed
#  in production environments by default.
group :assets do
  gem 'coffee-rails',            '~> 3.2',  '>= 3.2.1'
  gem 'less-rails',              '~> 2.2',  '>= 2.2.6'
  gem 'libv8',                   '~> 3.11', '>= 3.11.8'
#  See https://github.com/sstephenson/execjs#readme
#  for more supported JavaScript runtimes:
  gem 'therubyracer',            '~> 0.11', '>= 0.11.3', require: 'v8',
          platform: :ruby
  gem 'twitter-bootstrap-rails', '~> 2.1',  '>= 2.1.9'
  gem 'uglifier',                '~> 1.3',  '>= 1.3.0'
end

group :development do
  gem 'better_errors',     '~> 0.5',  '>= 0.5.0'
  gem 'binding_of_caller', '~> 0.6',  '>= 0.6.8'
  gem 'quiet_assets',      '~> 1.0',  '>= 1.0.1'
end

group :development, :test do
#  Keep (also) in the development group:
#    Factory girl, to use in the console.
#    RSpec, for generators and rake tasks.
  gem 'factory_girl_rails', '~> 4.2',  '>= 4.2.0'
  gem 'rspec-rails',        '~> 2.12', '>= 2.12.2'
end

group :production do
  gem 'thin', '~> 1.5',  '>= 1.5.0'
end

group :test do
  gem 'capybara',         '~> 2.0',  '>= 2.0.1'
  gem 'cucumber-rails',   '~> 1.3',  '>= 1.3.0', :require => false
  gem 'database_cleaner', '~> 0.9',  '>= 0.9.1'
  gem 'email_spec',       '~> 1.4',  '>= 1.4.0'
  gem 'launchy',          '~> 2.2',  '>= 2.2.0'
  gem 'mongoid-rspec',    '~> 1.5',  '>= 1.5.5'
end
