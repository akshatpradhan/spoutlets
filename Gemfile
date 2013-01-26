source :rubygems

# Mongoid 3 requires Ruby 1.9.3, per:
# http://mongoid.org/en/mongoid/index.html
ruby '1.9.3'
gem 'bundler', '>= 1.3.0.pre.2'
gem 'rack',    '>= 1.4.4'
gem 'rails',   ' = 3.2.11'
gem 'rake',    '>= 10.0.3'

gem 'cancan', '>= 1.6.8'
gem 'figaro', '>= 0.5.0'
gem 'jquery-rails'
gem 'libv8', '>= 3.11.8'
gem 'mongoid', '>= 3.0.14'
gem 'omniauth', '>= 1.1.1'
gem 'omniauth-facebook'
gem 'rolify', '>= 3.2.0'
gem 'simple_form', '>= 2.0.4'
gem 'thin', '>= 1.5.0'

group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'less-rails', '>= 2.2.6'
  gem 'therubyracer', '>= 0.11.0', platform: :ruby, require: 'v8'
  gem 'twitter-bootstrap-rails', '>= 2.1.8'
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
# Keep (also) in the development group:
#   Factory girl, to use in the console.
#   RSpec, for generators and rake tasks.
  gem 'factory_girl_rails', '>= 4.1.0'
  gem 'rspec-rails', '>= 2.11.4'
end

group :test do
  gem 'capybara', '>= 2.0.1'
  gem 'cucumber-rails', '>= 1.3.0', require: false
  gem 'database_cleaner', '>= 0.9.1'
  gem 'email_spec', '>= 1.4.0'
  gem 'launchy', '>= 2.1.2'
  gem 'mongoid-rspec', '>= 1.5.5'
end

group :development do
  gem 'better_errors', '>= 0.2.0'
  gem 'binding_of_caller', '>= 0.6.8'
  gem 'quiet_assets', '>= 1.0.1'
end
