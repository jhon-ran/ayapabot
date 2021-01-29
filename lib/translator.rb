require 'bundler'
Bundler.require

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
end

# CSV.open("db/dictionary.csv", "w") do |csv|
#   csv << ["perro", "taaga"]
# end

# CSV.open('db/dictionary.csv', "w", headers: ['español', 'ayapaneco1', 'ayapaneco2', 'ejemplo'], write_headers: true) do |csv|
#   csv << ['mano', 'ki', 'ku']
#   csv << ['sol', 'jaama']
#   csv << ['pie', 'chande']
#   csv << ["perro", "taaga"]
# end

#print CSV.read("db/dictionary.csv")

# Get the most recent tweet that says @ayapaneco como se dice ...?
client.search("to:ayapaneco como se dice", result_type: "recent").take(2).collect do |tweet|
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
            client.update("@#{tweet.user.screen_name} #{table[j][0]} se dice #{table[j][1]}", in_reply_to_status_id: tweet.id)
          # If word has 2 translations, reply to tweet to give translations
          elsif table[j][0] == word_in_spanish && table[j][2] != '*'
            client.update("@#{tweet.user.screen_name} #{table[j][0]} se dice #{table[j][1]} o #{table[j][2]}", in_reply_to_status_id: tweet.id)
          end
          j = j + 1
        end
      # If the table array does not include the word asked for, let user know we don't know that word yet
      else
        client.update("@#{tweet.user.screen_name} Lo siento, todavía no sé esa palabra. Pregúntame después.", in_reply_to_status_id: tweet.id)
      end
    end
    n = n + 1
  end
end

