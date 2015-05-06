class WelcomeController < ApplicationController
  def index
	@images = Image.all
	@pageinfos = Pageinfo.all
  end
end
