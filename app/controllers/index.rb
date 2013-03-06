require 'twitter'

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
