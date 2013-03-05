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
  config.consumer_key = "QTJQNOqYUMLmrowl1Qmw"
  config.consumer_secret = "gHOQqOdtZJJMpDm2mXaJEn1PfVzglPuXZfTPyAes"
  config.oauth_token = "89286429-x49cjYY4P6851JBWvmp9yC84KvH66tUuTYqj76xcO"
  config.oauth_token_secret = "eOvXE3s95uHK6eaI2MT6oLnNIioWrtK9On47sV2pxY"
end

run Sinatra::Application
