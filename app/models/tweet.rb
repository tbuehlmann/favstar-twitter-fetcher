class Tweet < ActiveRecord::Base
  attr_accessible :tweet_id

  validates :tweet_id, :presence => true
  validates :tweet_id, :uniqueness => true
  validates :tweet_id, :numericality => {
    :only_integer => true,
    :greater_than => 0
  }
  validates :author, :presence => true
  validates :text, :presence => true
  validates :tweeted_at, :presence => true

  def populate
    self.tweet_id = self.tweet_id.to_i

    if tweet_id > 0
      unless self.class.exists?(:tweet_id => tweet_id)
        response = HTTParty.get(twitter_status_url(tweet_id))

        # Keeping things simple here, no further error checking.
        # TODO: Making request async, this takes some time,
        if response.code == 200
          status = JSON.parse(response.body)
          self.author = status['user']['screen_name']
          self.text = status['text']
          self.tweeted_at = status['created_at']
        else
          errors[:base] << 'Something something occured!'
        end
      end
    end
  end

  private

  def twitter_status_url(tweet_id)
    "https://api.twitter.com/1/statuses/show/#{tweet_id}.json"
  end
end
