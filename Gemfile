#  'source :rubygems' insecure from man-in-the-middle attacks:
source 'https://rubygems.org'

#  Mongoid 3 requires Ruby 1.9.3 per http://mongoid.org/en/mongoid/index.html
ruby                      '1.9.3'

#  Gems normally needed by Rails:

gem 'bundler',                   '~> 1.3.0.pre'
gem 'jquery-rails',              '~> 2.2'
#  Rack 1.5 breaks Rails 3.2.11:
gem 'rack',                      '~> 1.4.0'
#  Include Rails 3.2.12 for security fixes:
gem 'rails',                     ' = 3.2.12'
gem 'rake',                      '~> 10.0'

# (End of gems normally needed by Rails.)

gem 'cancan',                    '~> 1.6'
gem 'figaro',                    '~> 0.5'
gem 'mongoid',                   '~> 3.0'
#  Omniauth gem is automatic with omniauth-facebook.
gem 'omniauth-facebook',         '~> 1.4'
gem 'rolify',                    '~> 3.2'
gem 'simple_form',               '~> 2.0'

#  Gems used only for assets and not needed
#  in production environments by default.
group :assets do
  gem 'coffee-rails',            '~> 3.2'
  gem 'less-rails',              '~> 2.2'
  gem 'libv8',                   '~> 3.11'
#  See https://github.com/sstephenson/execjs#readme
#  for more supported JavaScript runtimes:
  gem 'therubyracer',            '~> 0.11', require: 'v8', platform: :ruby
  gem 'twitter-bootstrap-rails', '~> 2.1'
  gem 'uglifier',                '~> 1.3'
end

group :development do
  gem 'better_errors',           '~> 0.5'
  gem 'binding_of_caller',       '~> 0.6'
  gem 'quiet_assets',            '~> 1.0'
end

group :development, :test do
#  Keep (also) in the development group:
#    Factory girl, to use in the console.
#    RSpec, for generators and rake tasks.
  gem 'factory_girl_rails',      '~> 4.2'
  gem 'rspec-rails',             '~> 2.12'
end

group :production do
  gem 'thin',                    '~> 1.5'
end

group :test do
  gem 'capybara',                '~> 2.0'
  gem 'cucumber-rails',          '~> 1.3', :require => false
  gem 'database_cleaner',        '~> 0.9'
  gem 'email_spec',              '~> 1.4'
  gem 'launchy',                 '~> 2.2'
  gem 'mongoid-rspec',           '~> 1.5'
end
