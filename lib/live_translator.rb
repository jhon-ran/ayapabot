require 'bundler'
Bundler.require

Dotenv.load

def static_twitter
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
  end
  return client
end

def live_twitter
  client = Twitter::Streaming::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
  end
  return client
end

def respond_to_tweet(tweet)
  # Turn each tweet into an array of words    
  array = tweet.text.split(" ")
  # Iterate through array to find the word "dice"
  n = 0
  while n < array.length
    if array[n] == "dice"
      # Take the word after dice and remove the ? if there is one and put in lowercase. Store in variable word_as_spanish.
      word_in_spanish = array[n + 1].delete_suffix('?').downcase
      # Search the dictionary for a match
      # Convert table into an array
      table = CSV.parse(File.read("db/dictionary.csv"), headers: true).map(&:fields)
      # If the table array includes the word asked for, give reply
      if table.flatten.include?(word_in_spanish)
        j = 0
        while j < table.length
          # If word has only 1 translation, reply to tweet give translation
          if table[j][0] == word_in_spanish && table[j][2] == '*'
            static_twitter.update("@#{tweet.user.screen_name} #{table[j][0]} se dice #{table[j][1]}", in_reply_to_status_id: tweet.id)
          # If word has 2 translations, reply to tweet to give translations
          elsif table[j][0] == word_in_spanish && table[j][2] != '*'
            static_twitter.update("@#{tweet.user.screen_name} #{table[j][0]} se dice #{table[j][1]} o #{table[j][2]}", in_reply_to_status_id: tweet.id)
          end
          j = j + 1
        end
      # If the table array does not include the word asked for, let user know we don't know that word yet
      else
        static_twitter.update("@#{tweet.user.screen_name} Lo siento, todavía no sé esa palabra. Pregúntame después.", in_reply_to_status_id: tweet.id)
      end
    end
    n = n + 1
  end
end

topics = ["ayapaneco como se dice", "ayapaneco ¿como se dice", "ayapaneco ¿cómo se dice", "ayapaneco cómo se dice"]
live_twitter.filter(track: topics.join(",")) do |object|
  tweet = object if object.is_a?(Twitter::Tweet)
  respond_to_tweet(tweet)
  end
