require 'bundler'
Bundler.require

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
end

table = CSV.parse(File.read("db/dictionary.csv"), headers: true).map(&:fields)

# Tweet action
#client.update("Gwübü'k tzu'ndyi. ¡Ya sé #{table.length} palabras!")

#buenas tardes message
client.update("Gwübü'k tu'k jáama. ¡Ya sé #{table.length} palabras!")