# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
# To enable requests for other host names to redirect to the canonical host
# heroku config:add CANONICAL_HOST=www.spoutlets.com
# https://github.com/tylerhunt/rack-canonical-host#environment-specific-configuration
use Rack::CanonicalHost, ENV['CANONICAL_HOST'] if ENV['CANONICAL_HOST']
run Spoutlets::Application
