require 'bundler'
Bundler.require

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

def translate_to_ayapaneco
  puts "Escribe la palabra que quieres traducir"
  word_to_translate = gets.chomp.downcase
  table = CSV.parse(File.read("db/dictionary.csv"), headers: true)
  i = 0
  while i < table.length
    if table[i][0] == word_to_translate && table[i][2] == nil
      puts "#{table[i][0]} se dice #{table[i][1]}"
    elsif table[i][0] == word_to_translate && table[i][2] != nil
      puts "#{table[i][0]} se dice #{table[i][1]} o #{table[i][2]}"
    end
    i = i + 1
  end
end

translate_to_ayapaneco