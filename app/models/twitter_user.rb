require 'twitter'

class TwitterUser < ActiveRecord::Base
  has_many :tweets
  has_many :followers

  # before_create :find_followers

  def fetch_tweets!
    Twitter.user_timeline(self.username, :count => 10).each do |tweet|
      Tweet.create(:content => tweet.text, 
                   :twitter_user_id => self.id, 
                   :tweeted_at => tweet.created_at)
    end
    Twitter.followers(self.username).each do |follower|
      Follower.create(:twitter_user_id => self.id, :username => follower.screen_name)
    end
  end

  def tweets_stale?
    # minimum_time_difference_between_tweets = self.tweets.each_cons(2).map { |a,b| b.tweeted_at - a.tweeted_at }.min
    Time.now - self.tweets.last.updated_at > 10
    # minimum_time_difference_between_tweets
  end

  private
  # def find_followers
  #   Twitter.followers(self.username).each do |follower|
  #     Follower.create(:twitter_user_id => self.id, :username => follower.screen_name)
  #   end
  # end
end
