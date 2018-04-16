class BrowsersController < ApplicationController
  def index
    @browsers = Browser.all

    @browsers.each do |browser|
      # https://stackoverflow.com/questions/808318/sorting-a-ruby-array-of-objects-by-an-attribute-that-could-be-nil
      # Sorts the array and leaves nil values at the end.
      browser.releases = browser.releases.sort { |a, b| a["release_date"] && b["release_date"] ? a["release_date"] <=> b["release_date"] : a["release_date"] ? -1 : 1 }
      
      # Collect all release dates which are nil so we can sort them separately.
      nil_release_dates = []
      browser.releases.each_with_index do |release_info, i|
        if release_info["release_date"].nil?
          nil_release_dates.push(i)
        end
      end

      nil_values = []
      nil_release_dates.each do |i|
        nil_values << browser.releases[i]
      end

      # Remove all releases with nil release dates from the browser releases.
      nil_values.each do |key, value|
        browser.releases.delete(key)
      end

      # Sort the nil_values array by the version number, then append it to the
      # browser releases.
      VersionSorter.sort!(nil_values) { |release| release["version"] }
      nil_values.each { |release| browser.releases.push(release) }
    end

    respond_to do |format|
      format.html
    end
  end
end
