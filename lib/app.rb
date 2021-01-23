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
#client.update("gwübü'k tzu'ndyi!")

# Like the 25 most recent tweets with the word "ayapaneco"
tweets = client.search("ayapaneco", result_type: "recent").take(5)
client.favorite(tweets)

# New comment