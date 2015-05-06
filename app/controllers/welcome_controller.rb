class WelcomeController < ApplicationController
  def index

  	@welcome = Pageinfo.find_by page: "welcome"

  end
end
