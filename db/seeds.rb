# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'

data = File.read('public/data.json')

data = JSON.parse(data)

css = data["css"]
html = data["html"]
browsers = data["browsers"]
browser_keys = []

# browsers.each do |key, browser|
#   5.times { puts " " }
#   puts key
#   browser["releases"].each { |key, release| puts "#{key}: #{release['release_date']}" }

#   browser_keys.push(key)
# end

# puts browser_keys

css.each do |key, feature|
  5.times { puts " " }
  puts key.to_s
  feature.each do |subkey, subfeature|
    puts subkey
    subfeature["__compat"]["support"].each do |browser_name, browser|
      puts browser_name
      # If the browser object has more than one subvalue it either has multiple
      # version notes or a separate note about flags/notes, we only want info
      # about what version it was added in.
      if browser.length > 1
        browser.each do |k, v|
          if k == "version_added"
            puts v
          end
        end
      else
        puts browser["version_added"]
      end
    end
    5.times { puts " " }
  end
end

css.each_with_index do |k, v, index|
  puts k
  puts v
  puts index
end
