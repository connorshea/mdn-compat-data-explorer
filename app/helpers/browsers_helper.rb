module BrowsersHelper
  def browser_releases_sorter(browsers)
    # Handle two main cases for the browsers value:
    # - where only a single Browser object is passed
    # - when an ActiveRecord Relation with multiple browsers is passed
    if browsers.kind_of?(Browser)
      release_sorter(browsers)
    else
      browsers.each do |browser|
        release_sorter(browser)
      end
    end

    return browsers
  end

  private

  def release_sorter(browser)
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
end
