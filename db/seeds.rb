# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'

@data = File.read('public/data.json')

@data = JSON.parse(@data)

# Full version:
# @top_level_schema = {
#   css: ["at-rules", "properties", "selectors", "types"],
#   html: ["elements", "global_attributes"],
#   javascript: ["builtins", "classes", "functions", "grammar", "operators", "statements"]
# }
@top_level_schema = {
  css: ["at-rules", "properties", "selectors", "types"],
  html: ["elements", "global_attributes"],
  javascript: ["builtins", "classes", "functions", "grammar", "operators", "statements"]
}

@browser_names = {
  chrome: "Chrome",
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
  uc_chinese_android: "Chinese UC Browser for Android"
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
    puts key.to_s
    releases = []
    @data['browsers'][key.to_s]['releases'].each_pair do |version, info|
      version_hash = { version: version.to_s }
      info = info.merge(version_hash)
      releases.push(info)
    end
    puts releases
    Browser.create(
      browser_id: key.to_s,
      name: @browser_names.fetch(key.to_sym).to_s,
      releases: releases
    )
  end
end

get_browser_keys(@data["browsers"])
seed_browser_data()
