# This script is for screwing around with parsing the MDN Browser Compat Data JSON file.
# It's very bad right now.
# I'm so sorry.

require 'json'

data = File.read('public/data.json')

data = JSON.parse(data)

# Full version:
# @top_level_schema = {
#   css: ["at-rules", "properties", "selectors", "types"],
#   html: ["elements", "global_attributes"],
#   javascript: ["builtins", "classes", "functions", "grammar", "operators", "statements"]
# }
@top_level_schema = {
  css: ["at-rules", "properties", "selectors", "types"]
}

# Gets info about each browser
def get_browser_keys(browsers)
  @browser_keys = []

  # Iterates through every browser and adds the key to an array of browsers.
  browsers.each do |key, browser|
    # 5.times { puts " " }
    # puts key
    # browser["releases"].each { |key, release| puts "#{key}: #{release['release_date']}" }

    @browser_keys.push(key)
  end
end

# This method does the following:
# - Takes the JSON data
# - Parses the schema data on what's described in the top_level_schema
# - Recursively goes through each child until it finds an item named "__compat"
# - The object it has will then have browser info, feature info, etc.
def recursive_parse_browser_data_schema(data_object, iteration, feature = nil)
  puts "Iteration: #{iteration}"
  # puts data_object.to_s.slice(0,200)
  if iteration.zero?
    get_browser_keys(data_object["browsers"])
    @top_level_schema.each_with_index do |(key, value), index|
      # puts "Key: #{key}"
      # puts "Value: #{value}"
      # puts "Index: #{index}"
      iteration += 1
      recursive_parse_browser_data_schema(data_object[key.to_s], iteration)
    end
  # If the data object has the __compat key that means it's time to parse
  # the browser support.
  elsif data_object.has_key?("__compat")
    # data_object["__compat"]["support"].each_with_index do |(key, value), index|
    #   puts "Key: #{key}"
    #   puts "Value: #{value.to_s.slice(0,100)}"
    #   puts "Index: #{index}"
    # end

    # Send the data to the browser_versions_supported method.
    browser_versions_supported(data_object["__compat"]["support"], feature)
  else
    iteration += 1
    data_object.each_with_index do |(key, value), index|
      # puts "Key: #{key}"
      # puts "Value: #{value.to_s.slice(0,100)}"
      # puts "Index: #{index}"

      # If the hash has a '__compat' key the key of the data object will
      # be the feature name, we pass that forward so it can be used by
      # the browser_versions_supported method later on.
      # Alternatively it may be a better idea to use the description property
      # of "__compat".
      if value.to_h.has_key?("__compat")
        feature_name = key
      end

      recursive_parse_browser_data_schema(data_object[key.to_s], iteration, feature_name)
    end
  end
end

# This method prints the browser support info from the JSON.
def browser_versions_supported(data_object, feature_name)
  @browser_keys.each do |browser_key|
    if data_object.key?(browser_key)
      puts " "
      puts "Support for #{feature_name} in #{browser_key}"

      # This can either be a Hash or an Array, depending on the specific case.
      # puts data_object[key.to_s][key2.to_s][key3.to_s]["__compat"]["support"][browser_key.to_s]
      # 
      # If it's an Array.
      if data_object[browser_key.to_s].kind_of?(Array)
        puts "Data: #{data_object[browser_key.to_s]}"
        data_object[browser_key.to_s].each_with_index do |info, index|
          info.keys.each do |key, value|
            # This should handle `version_added = nil` somehow.
            # Right now it just outputs a blank value, it should instead
            # say "unknown".
            puts "#{key}: #{info[key.to_s]}"
          end
          unless index + 1 == data_object[browser_key.to_s].size
            puts "--------"
          end
        end
      # If it's a Hash.
      elsif data_object[browser_key.to_s].kind_of?(Hash)
        puts "Data: #{data_object[browser_key.to_s]}"
        data_object[browser_key.to_s].keys.each do |key, value|
          puts "#{key.to_s}: #{data_object[browser_key.to_s][key.to_s]}"
        end
      end
    end
  end
end

recursive_parse_browser_data_schema(data, 0)
