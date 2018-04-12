# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'pp'

data = File.read('public/data.json')

data = JSON.parse(data)

css = data[:css]
html = data["html"]

def get_browser_keys(browsers)
  @browser_keys = []

  browsers.each do |key, browser|
    5.times { puts " " }
    puts key
    browser["releases"].each { |key, release| puts "#{key}: #{release['release_date']}" }

    @browser_keys.push(key)
  end
end

# puts browser_keys

# css.each do |key, feature|
#   5.times { puts " " }
#   puts key.to_s
#   feature.each do |subkey, subfeature|
#     puts subkey
#     subfeature[:__compat][:support].each do |browser_name, browser|
#       puts browser_name
#       # If the browser object has more than one subvalue it either has multiple
#       # version notes or a separate note about flags/notes, we only want info
#       # about what version it was added in.
#       if browser.length > 1
#         browser.each do |k, v|
#           if k == :version_added
#             puts v
#           end
#         end
#       else
#         puts browser[:version_added]
#       end
#     end
#     5.times { puts " " }
#   end
# end

# css.each do |k, v|
#   # puts "k: #{k}"
#   # puts "v: #{v}"

#   v.each do |k2, v2|
#     puts "k2: #{k2}"
#     puts "v2: #{v2}"

#     v2.each do |k3, v3|
#       puts "k3: #{k3}"
#       puts "v3: #{v3}"
#     end
#   end
# end

def parse_browser_data_schema(data_object)
  # puts object

  # top_level_schema = {
  #   css: ["at-rules", "properties", "selectors", "types"],
  #   html: ["elements", "global_attributes"],
  #   javascript: ["builtins", "classes", "functions", "grammar", "operators", "statements"]
  # }

  get_browser_keys(data_object["browsers"])

  top_level_schema = {
    css: ["at-rules", "properties", "selectors", "types"]
  }

  top_level_schema.each_with_index do |(key, value), index|
    puts "Key: #{key}"
    puts "Value: #{value}"
    puts "Index: #{index}"

    value.each_with_index do |(key2, value2), index2|
      puts "Key2: #{key2}"
      puts "Index2: #{index2}"
      puts "List all children of this key"
      puts data_object["#{key}"]["#{key2}"].keys

      data_object["#{key}"]["#{key2}"].each_with_index do |(key3, value3), index3|
        # puts data_object[key.to_s][key2.to_s][key3.to_s].keys
        puts " "
        # puts "FEATURE"
        # puts key3.to_s
        # puts data_object[key.to_s][key2.to_s][key3.to_s]["__compat"]["support"]

        @browser_keys.each do |browser_key|
          if data_object[key.to_s][key2.to_s][key3.to_s]["__compat"]["support"].key?(browser_key)
            puts " "
            puts "Support for #{key3} in #{browser_key}"
            # This can either be a Hash or an Array, depending on the specific case.
            # puts data_object[key.to_s][key2.to_s][key3.to_s]["__compat"]["support"][browser_key.to_s]

            # If it's an array.
            if data_object[key.to_s][key2.to_s][key3.to_s]["__compat"]["support"][browser_key.to_s].kind_of?(Array)
              # puts "IT'S AN ARRAY!"
              data_object[key.to_s][key2.to_s][key3.to_s]["__compat"]["support"][browser_key.to_s].each do |info|
                # puts info["version_added"]
                # puts "key: #{info}"
                info.keys.each do |k, v|
                  puts "#{k.to_s}: #{info[k.to_s]} "
                end
                # puts "===== test ====="
              end
            # If it's a Hash
            else 
              # puts data_object[key.to_s][key2.to_s][key3.to_s]["__compat"]["support"][browser_key.to_s]["version_added"]

              data_object[key.to_s][key2.to_s][key3.to_s]["__compat"]["support"][browser_key.to_s].keys.each do |k, v|
                puts "#{k.to_s}: #{data_object[key.to_s][key2.to_s][key3.to_s]["__compat"]["support"][browser_key.to_s][k.to_s]} "
              end
            end
            # puts data_object[key.to_s][key2.to_s][key3.to_s]["__compat"]["support"][browser_key.to_s].class
          end
        end
      end

      # data_object_dug = data_object.dig(key.to_s, key2.to_s)
      # puts data_object_dug
    end
  end
end

parse_browser_data_schema(data)
