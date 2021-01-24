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

table = CSV.parse(File.read("db/dictionary.csv"), headers: true)

print table

puts "Escribe la palabra que quieres traducir"
word_to_translate = gets.chomp
