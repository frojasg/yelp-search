require 'json'

categories = JSON.parse(File.read("categories.json"), symbolize_names: true)

categories.select do |category|
  Array(category[:parents]).include?("restaurants")
end.each do |category|
  puts "@{@\"name\": @\"#{category[:title]}\", @\"code\": @\"#{category[:alias]}\"},"
end
