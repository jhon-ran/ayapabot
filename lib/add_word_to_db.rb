require 'bundler'
Bundler.require

# Get input from user
puts "Español: "
español = gets.chomp
puts "Ayapaneco1: "
ayapaneco1 = gets.chomp
puts "Ayapaneco2: "
ayapaneco2 = gets.chomp
puts "Raíz: "
raiz = gets.chomp
puts "Ejemplo: "
ejemplo = gets.chomp

# Add input to last row of CSV
File.open("db/dictionary.csv", 'a+') {|f| f.write("#{español},#{ayapaneco1},#{ayapaneco2},#{raiz},#{ejemplo}\n")}

# Convert CSV table into an array
table = CSV.parse(File.read("db/dictionary.csv"), headers: true)

# Sort words alphabetically (but removes headers!)
File.write("db/dictionary.csv", table.sort_alphabetical.map(&:to_csv).join)

# Add header back in
CSV.open("db/dictionary.csv"+ '.tmp', 'w', write_headers: true, headers: ["español", "ayapaneco1" ,"ayapaneco2", "raíz", "ejemplo"]) do |dest|
  # Transpose original data
  CSV.open("db/dictionary.csv") do |source|
    source.each do |row|
      dest << row
    end
  end
end

# Swap new version for old
File.rename("db/dictionary.csv" + '.tmp', "db/dictionary.csv")
