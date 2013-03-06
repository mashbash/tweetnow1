require 'twitter'

before do
  session[:oauth] ||= {}            # we'll store the request and access tokens here
  host = request.host
  host << ":9292" if request.host == "localhost"
  consumer_key = CONSUMER_KEY       # what twitter.com/apps says   
  consumer_secret = CONSUMER_SECRET # shhhh, its a secret   
  @consumer = OAuth::Consumer.new(consumer_key, consumer_secret, :site => "http://twitter.com")
  # generate a request token for this user session if we haven't already
  request_token = session[:oauth][:request_token]   
  request_token_secret = session[:oauth][:request_token_secret]
  if request_token.nil? || request_token_secret.nil?
    # new user? create a request token and stick it in their session
    @request_token = @consumer.get_request_token(:oauth_callback => "http://#{host}/auth")
    session[:oauth][:request_token] = @request_token.token
    session[:oauth][:request_token_secret] = @request_token.secret
  else
    # we made this user's request token before, so recreate the object
    @request_token = OAuth::RequestToken.new(@consumer, request_token, request_token_secret)
  end
  # this is what we came here for...   
  access_token = session[:oauth][:access_token]   
  access_token_secret = session[:oauth][:access_token_secret]
  unless access_token.nil? || access_token_secret.nil?
    # the ultimate goal is to get here, where we can create our Twitter @client   
    # object
    @access_token = OAuth::AccessToken.new(@consumer, access_token, access_token_secret)    
    oauth = Twitter::OAuth.new(consumer_key, consumer_secret)     
    oauth.authorize_from_access(@access_token.token, @access_token.secret)     
    @client = Twitter::Base.new(oauth)
  end 
end   

get "/request" do
  redirect @request_token.authorize_url
end

get "/auth" do
  @access_token = @request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session[:oauth][:access_token] = @access_token.token
  session[:oauth][:access_token_secret] = @access_token.secret
  redirect "/"
end


get '/' do
  erb :index
end

post '/tweets' do
  begin
    Twitter.update(params[:tweet])
  rescue Twitter::Error => error
    
    @error = error
  end
  
  @username = params[:username]
  @tweet = params[:tweet]
  erb :_add_tweet,
      :layout => false,
      :locals => {:username => @username, :tweet => @tweet, :error => @error}
end
# get '/:username' do
#   @user = TwitterUser.find_or_create_by_username(params[:username])
#   @tweets = @user.tweets.limit(10) if @user
#   @followers = @user.followers
#   if @user.tweets.empty? || @user.tweets_stale?
#     erb :stale
#   else
#     erb :fresh
#   end
# end

# post '/:username' do
#   @user = TwitterUser.find_by_username(params[:username])
#   @user.fetch_tweets!
#   erb :_tweets, :layout => false, :locals => {:user => @user, :tweets => @user.tweets.limit(10)}
# end
