require 'rails_helper'

RSpec.describe Pageinfo, type: :model do
  
  it "should be valid" do
	expect(Pageinfo.new(:page => "page",
		:body => "textext")).to be_valid
  end
end
