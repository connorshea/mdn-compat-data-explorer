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
end
