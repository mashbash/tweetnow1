# Require config/environment.rb
require ::File.expand_path('../config/environment',  __FILE__)

set :app_file, __FILE__

configure do
  # See: http://www.sinatrarb.com/faq.html#sessions
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || 'this is a secret shhhhh'

  # Set the views to 
  set :views, File.join(Sinatra::Application.root, "app", "views")
end

Twitter.configure do |config|
  config.consumer_key = "67ZedRa4gv5u29E7KM0CQ"
  config.consumer_secret = "DN8PL4Q7Crgv6S7Hg6X1NMVBXmXzF07E7kT5Ja4PQw"
  config.oauth_token = "1244778728-KyWIyW6cehSyIrUQeiOsosb9pWKomDCr0aXws1O"
  config.oauth_token_secret = "pjCdBk7PhXekPXHR8sxhSxaTLT5nkf1fmh9VuhGJw7s"
end

run Sinatra::Application
