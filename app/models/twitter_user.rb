require 'twitter'

class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def fetch_tweets!
    Twitter.user_timeline(self.username, :count => 10).each do |tweet|
      Tweet.create(:content => tweet.text, 
                   :twitter_user_id => self.id, 
                   :tweeted_at => tweet.created_at)
    end
  end

  def tweets_stale?
    minimum_time_difference_between_tweets = self.tweets.each_cons(2).map { |a,b| b.tweeted_at - a.tweeted_at }.min
    Time.now - self.tweets.last.updated_at > minimum_time_difference_between_tweets
  end
end
