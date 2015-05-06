class WelcomeController < ApplicationController
  def index
	@images = Image.all
  	@welcome = Pageinfo.find_by page: "welcome"
  	@about = Pageinfo.find_by page: "about"
  end
end
