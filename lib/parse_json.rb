# This script is for screwing around with parsing the MDN Browser Compat Data JSON file.
# It's very bad right now.
# I'm so sorry.

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

# Currently, this method sucks.
# What it does:
# - Takes the JSON data
# - Parses the data based on what's described in the top_level_schema
# - Drills down a few layers until it can access the "__compat" item
# - Manually prints information about the browser support for a given feature.
#
# The problem with this is that the number of layers is hardcoded.
# For various cases, the number of layers differs, so recursion would make
# for far better code.
#
# What it should do:
# - Takes the JSON data
# - Parses the schema data on what's described in the top_level_schema
# - Recursively goes through each child until it finds an item named "__compat"
# - The object it has will then have browser info, feature info, etc.
def parse_browser_data_schema(data_object)
  get_browser_keys(data_object["browsers"])

  # Full version:
  # top_level_schema = {
  #   css: ["at-rules", "properties", "selectors", "types"],
  #   html: ["elements", "global_attributes"],
  #   javascript: ["builtins", "classes", "functions", "grammar", "operators", "statements"]
  # }
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
        puts "KEYS"
        puts data_object[key.to_s][key2.to_s][key3.to_s]["__compat"].keys

        @browser_keys.each do |browser_key|
          if data_object[key.to_s][key2.to_s][key3.to_s]["__compat"]["support"].key?(browser_key)
            puts " "
            puts "Support for #{key3} in #{browser_key}"
            # This can either be a Hash or an Array, depending on the specific case.
            # puts data_object[key.to_s][key2.to_s][key3.to_s]["__compat"]["support"][browser_key.to_s]
            # 
            # If it's an Array.
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
    end
  end
end

parse_browser_data_schema(data)
