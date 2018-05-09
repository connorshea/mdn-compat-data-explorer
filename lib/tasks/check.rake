namespace :check do
  desc "Checks the BCD npm package version against the Rails config."
  task :check_mdn_bcd_version do
    version = `yarn info mdn-browser-compat-data version --silent`
    version = version.strip
    # puts "'#{version}'"
    # puts "'#{Rails.configuration.mdn_bcd_version}'"
    if version != Rails.configuration.mdn_bcd_version
      abort("Version mismatch, version in yarn.lock (#{version}) doesn't match version in config/application.rb (#{Rails.configuration.mdn_bcd_version}).")
    end
  end

  desc "Checks that the JSON files are valid."
  task :check_json do
    require "json"

    @data = File.read('public/data.json')
    @data_test = File.read('public/data-test.json')

    begin
      JSON.parse(@data)
      JSON.parse(@data_test)
    rescue Exception => e
      abort(e)
    end
  end

  desc "Checks all MDN URLs in the dataset for 404s, this shouldn't be run very often because the MDN rate limiter doesn't like it."
  task :check_404s => :environment do
    require "net/http"
    features = Feature.where.not(mdn_url: nil)
    puts features.count

    urls = %w()
    features.each do |feature|
      urls.push(feature.mdn_url)
    end

    urls_that_404 = %w()

    THREAD_COUNT = 16
    mutex = Mutex.new

    THREAD_COUNT.times.map {
      Thread.new(urls) do |urls|
        while url = mutex.synchronize { urls.pop }
          response = nil
          original_url = url
          begin
            5.times do
              url = URI.parse(url)
              response = Net::HTTP.new(url.host, url.port)
              response.use_ssl = true
              # Don't retry
              response.max_retries = 0

              response = response.request_head(url.path)
              # If redirect, keep going
              if response.kind_of?(Net::HTTPRedirection)
                url = response['location']
              # If not a redirect, it's time to stop!
              else
                # puts "Found: #{url}"
                break
              end
            end

            if response.kind_of?(Net::HTTPNotFound)
              puts "404: #{url}"
              mutex.synchronize { urls_that_404.push(url) }
            elsif response.kind_of?(Net::HTTPFound) || response.kind_of?(Net::HTTPOK)
              # puts "Found"
            elsif response.kind_of?(Net::HTTPTooManyRequests)
              # The MDN rate limiter tells us to stop, so we take a break, set
              # the url back to its original state, and redo.
              puts "HTTPTooManyRequests"
              sleep(25)
              url = original_url
              redo
            else
              puts url
              puts response.class
            end
          rescue Exception => e
            puts e
          end
        end
      end
    }.each(&:join)

    10.times { puts "" }
    puts urls_that_404.count
    puts "URLs that 404:"
    puts urls_that_404
  end
end
