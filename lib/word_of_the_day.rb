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

word_of_the_day = table.sample

if word_of_the_day[2] == '*'
  client.update("Gwübü'k tzu'ndyi. La palabra del día es #{word_of_the_day[1]} --> '#{word_of_the_day[0]}'")
  #Afternoon
  #client.update("Gwübü'k tu'k jaama. La palabra del día es #{word_of_the_day[1]} --> '#{word_of_the_day[0]}'")
  
else
  client.update("Gwübü'k tzu'ndyi. La palabra del día es #{word_of_the_day[1]} o #{word_of_the_day[2]} --> '#{word_of_the_day[0]}'")
  #Afternoon
  #client.update("Gwübü'k tu'k jaama. La palabra del día es #{word_of_the_day[1]} o #{word_of_the_day[2]} --> '#{word_of_the_day[0]}'")
end