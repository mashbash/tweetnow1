class CreateTweetTable < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.datetime  :tweeted_at  
      t.integer :twitter_user_id
      t.timestamps
    end
  end
end
