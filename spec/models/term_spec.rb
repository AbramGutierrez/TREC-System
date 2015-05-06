require 'rails_helper'

RSpec.describe Term, type: :model do
  it "should be valid" do
		expect(Term.new(:order => 1,
		:title => "this is a title",
		:body => "this is a long body")).to be_valid
	end
	
	it "should require order" do
		expect(Term.new(
		:title => "this is a title",
		:body => "this is a long body")).to_not be_valid
	end
	
	it "should require body" do
		expect(Term.new(:order => 1,
		:title => "this is a title")).to_not be_valid
	end
	
	it "should require a positive order number" do
		expect(Term.new(:order => -1,
		:title => "this is a title",
		:body => "this is a long body")).to_not be_valid
	end
end
