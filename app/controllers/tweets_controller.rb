class TweetsController < ApplicationController
  def index
    @tweets = Tweet.order('tweeted_at DESC').decorate
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(params[:tweet])
    tweet.populate

    if tweet.save
      flash[:highlight] = tweet.tweet_id
      redirect_to root_url(:anchor => tweet.tweet_id), :notice => 'Tweet saved.'
    else
      # Keeping things simple in here.
      redirect_to root_url, :alert => 'Tweet could not be fetched/saved.'
    end
  end
end
