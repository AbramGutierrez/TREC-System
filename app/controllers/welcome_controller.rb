class WelcomeController < ApplicationController
  def index

  	@welcome = Pageinfo.find_by page: "welcome"
  	@about = Pageinfo.find_by page: "about"

  end
end
