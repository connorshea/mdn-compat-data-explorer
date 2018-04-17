# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'database_cleaner'

# Make sure the DB is cleaned before seeding.
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

@data = File.read('public/data.json')

@data = JSON.parse(@data)

# Full version:
# @top_level_schema = {
  # api: [],
  # browsers: [],
  # css: ["at-rules", "properties", "selectors", "types"],
  # html: ["elements", "global_attributes"],
  # http: [],
  # javascript: ["builtins", "classes", "functions", "grammar", "operators", "statements"]
  # svg: [],
  # webdriver: [],
  # webextensions: []
# }
@top_level_schema = {
  api: [],
  css: ["at-rules", "properties", "selectors", "types"],
  html: ["elements", "global_attributes"],
  http: [],
  javascript: ["builtins", "classes", "functions", "grammar", "operators", "statements"],
  svg: [],
  webdriver: [],
  webextensions: []
}

@browser_names = {
  chrome: "Chrome",
  chrome_android: "Chrome for Android",
  edge: "Edge",
  edge_mobile: "Edge Mobile",
  firefox: "Firefox",
  firefox_android: "Firefox Android",
  ie: "Internet Explorer",
  nodejs: "NodeJS",
  opera: "Opera",
  qq_android: "QQ Android",
  safari: "Safari",
  safari_ios: "Safari Mobile",
  samsunginternet_android: "Samsung Internet for Android",
  uc_android: "UC Browser for Android",
  uc_chinese_android: "Chinese UC Browser for Android",
  webview_android: "Android Webview"
}

# Gets info about each browser
def get_browser_keys(browsers)
  @browser_keys = []

  # Iterates through every browser and adds the key to an array of browsers.
  browsers.each do |key, browser|
    @browser_keys.push(key)
  end
end

def seed_browser_data()
  @browser_keys.each do |key, value|
    # puts key.to_s
    releases = []
    @data['browsers'][key.to_s]['releases'].each_pair do |version, info|
      version_hash = { version: version.to_s }
      info = info.merge(version_hash)
      releases.push(info)
    end
    # puts releases
    Browser.create(
      browser_id: key.to_s,
      name: @browser_names.fetch(key.to_sym).to_s,
      releases: releases
    )
  end
end

def recursive_parse_browser_data_schema(data_object, iteration, feature_path=[])
  # If this is the first iteration it'll run through each item in the
  # top-level schema, once everything has been run-through the method
  # won't recurse again.
  if iteration.zero?
    get_browser_keys(data_object["browsers"])
    seed_browser_data()
    @top_level_schema.each_with_index do |(key, value), index|
      iteration += 1
      feature_path = [key.to_s]
      recursive_parse_browser_data_schema(data_object[key.to_s], iteration, feature_path)
    end
  # If the data object has the __compat key that means it's time to parse
  # the browser support.
  elsif data_object.has_key?("__compat")
    create_feature(
      feature_path.join("."), #name
      data_object["__compat"]["description"], # description
      data_object["__compat"]["mdn_url"], # mdn_url
      data_object["__compat"]["status"], #status
      data_object["__compat"]["support"] #support object
    )

    if data_object.keys.length > 1
      data_object.keys.each_with_index do |(key, value), index|
        if key == "__compat"
          next
        end

        new_feature_path = feature_path.dup
        new_feature_path.push(key)

        iteration += 1
        recursive_parse_browser_data_schema(data_object[key.to_s], iteration, new_feature_path)
      end
    end

  elsif !data_object.has_key?("__compat")
    iteration += 1
    data_object.each_with_index do |(key, value), index|

      new_feature_path = feature_path.dup
      new_feature_path.push(key)

      iteration += 1
      recursive_parse_browser_data_schema(data_object[key.to_s], iteration, new_feature_path)
    end
  end
end


def create_feature(name, description=nil, mdn_url=nil, status=nil, support_object)
  # puts "CREATE FEATURE"
  # puts "support_object: #{support_object}"
  # puts "name: #{name}"
  # puts "Description: #{description}"
  # puts "mdn_url: #{mdn_url}"
  # puts "Status: #{status}"

  hash = {
    name: name,
    description: description,
    mdn_url: mdn_url
  }

  ["deprecated", "experimental", "standard_track"].each do |status_key|
    unless status.nil?
      hash[status_key] = status[status_key]
    end
  end

  @browser_names.keys.each do |browser|
    unless browser.nil?
      # puts support_object[browser.to_s]
      hash[browser.to_s] = support_object[browser.to_s]
    end
  end

  Feature.create(hash)
end

get_browser_keys(@data["browsers"])
seed_browser_data()
recursive_parse_browser_data_schema(@data, 0)
