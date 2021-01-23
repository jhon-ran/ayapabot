require 'dotenv'
require 'twitter'

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
end

# Tweet action
# client.update("gwübü'k tzu'ndyi!")

# Like the 20 most recent tweets with the word "ayapaneco"
tweets = client.search("ayapaneco", result_type: "recent").take(20)

# Don't like our own tweets
i = 0
while i < tweets.length
  if tweets[i].user.screen_name == "ayapaneco"
    tweets.delete_at(i)
  end
  i = i + 1
end

client.favorite(tweets)
