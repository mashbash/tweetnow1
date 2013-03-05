require 'twitter'

get '/' do
  erb :index
end

get '/:username' do
  @user = TwitterUser.find_or_create_by_username(params[:username])
  @tweets = @user.tweets.limit(10) if @user
  @followers = @user.followers
  if @user.tweets.empty? || @user.tweets_stale?
    erb :stale
  else
    erb :fresh
  end
end

post '/:username' do
  @user = TwitterUser.find_by_username(params[:username])
  @user.fetch_tweets!
  erb :_tweets, :layout => false, :locals => {:user => @user, :tweets => @user.tweets.limit(10)}
end
