class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :tweet_id
      t.string :author
      t.string :text
      t.datetime :tweeted_at

      t.timestamps
    end
  end
end
