class CreateFollowersTable < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer   :twitter_user_id
      t.string   :username
    end
  end
end
