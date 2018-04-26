class GraphsController < ApplicationController
  def index
    @browser_stats = Hash.new

    @browsers = Rails.configuration.browsers

    @browsers.keys.each do |browser|
      stats = {
        unknown: Feature.public_send("#{browser}_nil").count,
        yes: Feature.public_send("#{browser}_true").count,
        no: Feature.public_send("#{browser}_false").count,
        no_data: Feature.public_send("#{browser}_no_data").count
      }

      @browser_stats[browser] = stats
      
      total = 0
      puts "#{browser}"
      @browser_stats[browser].each do |key, value|
        puts "Key: #{key}, Val: #{value}"
        total += value
        puts "total: #{total}"
      end

      @browser_stats[browser][:total] = total
    end

    @feature_count = Feature.all.count
  end
end
