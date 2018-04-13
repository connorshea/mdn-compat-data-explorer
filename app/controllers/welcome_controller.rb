class WelcomeController < ApplicationController
  def index
    @browsers = Browser.all
  end
end
