# driver script to test some things

require_relative "lib/hash_map"

map = HashMap.new
map["name"] = "Josh"
map["age"] = 33
map["occupation"] = "Software Engineer"
map["location"] = "United States"

keys_to_fill_space = %w[keys to test if the hash map is growing properly or not xD]
keys_to_fill_space.each { |key| map[key] = 5 }

puts <<~HEREDOC
  Name key should be 'Josh': #{map["name"]}
  Age key should be 33: #{map["age"]}
  Occupation key should be 'Software Engineer': #{map["occupation"]}
  Location key should be 'United States': #{map["location"]}
  Fake key can't be gotten: #{map["fake"]}

  'Not' key should be 5: #{map["not"]}
  Length key should be 17: #{map.length}

  Fake key returns false for `key?`: #{map.key?("fake")}
  Occupation key returns true for `key?`: #{map.key?("occupation")}

  Location key can be removed: #{map.remove("location")}
  And can no longer be accessed: #{map["location"]}

  Fake key can't be removed: #{map.remove("fake")}

HEREDOC

p map.entries
p map.keys
p map.values

map.clear

p map.entries
