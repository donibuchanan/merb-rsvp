# Go to http://wiki.merbivore.com/pages/init-rb
 
require 'config/dependencies.rb'
require 'merb_jquery'
# Main class
require 'lib/acts_as_unvlogable'
# Gems & other herbs
require 'open-uri'
require 'hpricot'

use_orm :datamapper
use_test :rspec
use_template_engine :erb
 
Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'cookie'  # can also be 'memory', 'memcache', 'container', 'datamapper
  
  # cookie session store configuration
  c[:session_secret_key]  = 'e7370a4d3a0899997d0f1a73553e7038a9e11c9c'  # required for cookie session store
  c[:session_id_key] = '_rsvp_session_id' # cookie session id key, defaults to "_session_id"
end
 
Merb::BootLoader.before_app_loads do
  # This will get executed after dependencies have been loaded but before your app's classes have loaded.
end
 
Merb::BootLoader.after_app_loads do
  Merb.add_mime_type :csv, :to_s, %w[application/csv]
  require 'config/mail_init'
end
