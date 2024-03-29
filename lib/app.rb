require 'bundler'
Bundler.require

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
end

# Tweet action
# client.update("gwübü'k tzu'ndyi!")

# Like and retweet the 5 most recent tweets with the word "ayapaneco"
tweets = client.search("ayapaneco", result_type: "recent").take(5)

# Don't like or retweet our own tweets
i = 0
while i < tweets.length
  if tweets[i].user.screen_name == "ayapaneco"
    tweets.delete_at(i)
  end
  i = i + 1
end

# Comment the line below if you only want to retweet
client.favorite(tweets)

# Comment the line below if you only want to like
client.retweet tweets

