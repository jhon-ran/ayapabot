require 'bundler'
Bundler.require

# Converts csv table into an array
table = CSV.parse(File.read("db/dictionary.csv"), headers: true).map(&:fields)
i = 0
while i < table.length 
  table[i][3], table[i][4] = table[i][4], table[i][3]
  i = i + 1
end

File.write("db/dictionary.csv", table.map(&:to_csv).join)



# n = 0
# while n < table.length
#   CSV.open("db/dictionary.csv", "w") do |csv|
#     csv << table[n]
#   end
#   n = n + 1
# end