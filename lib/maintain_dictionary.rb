require 'bundler'
Bundler.require

# Converts csv table into an array
table = CSV.parse(File.read("db/dictionary.csv"), headers: true).map(&:fields)

# Change order of columns 4 and 5
i = 0
while i < table.length 
  table[i][3], table[i][4] = table[i][4], table[i][3]
  i = i + 1
end

# Write new table to csv (this didn't include headers so we added them back in manually in csv)
File.write("db/dictionary.csv", table.map(&:to_csv).join)