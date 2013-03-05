require 'twitter'

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/:username' do
  @timeline = Twitter.user_timeline(params[:username])
  @user = TwitterUser.find_or_create_by_username(params[:username])
  if @user.tweets.empty? || @user.tweets_stale?
    @user.fetch_tweets!
  end

  @tweets = @user.tweets.limit(10)
  erb :tweets
end
