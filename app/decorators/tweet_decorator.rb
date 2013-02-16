class TweetDecorator < Draper::Decorator
  delegate_all

  def tweeted_at
    if source.tweeted_at.respond_to? :strftime
      source.tweeted_at.strftime('%Y-%m-%d %H:%M:%S')
    else
      source.tweeted_at
    end
  end

  def url
    "https://twitter.com/#{source.author}/status/#{source.tweet_id}"
  end

  def author_url
    "https://twitter.com/#{source.author}"
  end
end
