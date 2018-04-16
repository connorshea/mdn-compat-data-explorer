class BrowsersController < ApplicationController
  def index
    @browsers = Browser.all

    @browsers.each do |browser|
      # https://stackoverflow.com/questions/808318/sorting-a-ruby-array-of-objects-by-an-attribute-that-could-be-nil
      # Sorts the array and leaves nil values at the end.
      browser.releases = browser.releases.sort { |a, b| a["release_date"] && b["release_date"] ? a["release_date"] <=> b["release_date"] : a["release_date"] ? -1 : 1 }

      nil_values = []
      browser_releases_with_release_dates = []
      browser.releases.each_with_index do |release_info, i|
        # Collect all release dates which are nil so we can sort them
        # separately.
        if release_info["release_date"].nil?
          nil_values << browser.releases[i]
        # Collect all releases with release date values.
        else
          browser_releases_with_release_dates << browser.releases[i]
        end
      end

      # Replace browser.releases with the array of releases that have valid
      # release dates. This is a workaround means of deleting all nil values.
      browser.releases = browser_releases_with_release_dates

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
