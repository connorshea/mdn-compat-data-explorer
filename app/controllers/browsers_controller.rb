class BrowsersController < ApplicationController
  def index
    @browsers = helpers.browser_releases_sorter(Browser.all)

    respond_to do |format|
      format.html
    end
  end

  def show
    @browser = Browser.find(params[:id])
    @browser = helpers.browser_releases_sorter(@browser)
  end
end
