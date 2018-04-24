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
end
