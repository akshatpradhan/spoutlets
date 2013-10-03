source 'https://rubygems.org'
ruby '1.9.3'
gem 'rails', '3.2.13'
group :assets do
  gem "less-rails", ">= 2.2.6"
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem "twitter-bootstrap-rails", "~> 2.2.8"
  gem "therubyracer", ">= 0.11.0", :platform => :ruby, :require => "v8"
  gem "designmodo-flatuipro-rails", "~> 1.1.3"
  gem "jquery-ui-rails", "~> 4.0.4"

end

group :development do
  gem "quiet_assets", "~> 1.0.2"
  gem "better_errors", "~> 0.9.0"
  gem "binding_of_caller", "~> 0.7.1"
  gem "jazz_hands", "~> 0.5.0"
end

group :test do
  gem "database_cleaner", "~> 1.0.1"
  gem "mongoid-rspec", "~> 1.8.2"
  gem "email_spec", "~> 1.4.0"
  gem "launchy", "~> 2.3.0"
  gem "capybara", "~> 2.1.0"
  gem "selenium-webdriver", "~> 2.35"
  gem "cucumber-rails", "~> 1.3.1", :require => false
  gem "guard-rspec"
end

group :development, :test do
  gem "rspec-rails", "~> 2.13.2"
  gem "factory_girl_rails", "~> 4.2.1"
  gem "poltergeist"
end

gem 'jquery-rails'
gem 'lazy_high_charts', "~>1.4.2"
gem "thin", ">= 1.5.0"
# Per http://packages.qa.debian.org/m/mongodb.html
#   Debian squeeze backports (stable-bpo) runs mongodb 2.0.0.
# Per http://mongoid.org/en/mongoid/docs/installation.html#installation
#   with mongodb 2.0.0, gem mongoid must be 3.0.x (~> 3.0.1).
gem "mongoid", "~> 3.0.1"
gem "libv8", ">= 3.11.8"
gem "omniauth", ">= 1.1.1"
gem "omniauth-facebook"
gem "omniauth-linkedin-oauth2"
gem "cancan", ">= 1.6.8"
gem "rolify", ">= 3.2.0"
gem "simple_form", ">= 2.0.4"
gem "figaro", "~> 0.6"
gem "devise", "~> 2.2.4"
gem 'devise_invitable', '~> 1.1.8'
gem 'mongoid-likeable', '~> 2.0.1'
