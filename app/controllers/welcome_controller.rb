class WelcomeController < ApplicationController
  def index
    @browsers = Browser.all

    @browsers.each do |browser|
      # https://stackoverflow.com/questions/808318/sorting-a-ruby-array-of-objects-by-an-attribute-that-could-be-nil
      # Sorts the array and leaves nil values at the end.
      browser.releases = browser.releases.sort { |a, b| a["release_date"] && b["release_date"] ? a["release_date"] <=> b["release_date"] : a["release_date"] ? -1 : 1 }
    end
  end
end
