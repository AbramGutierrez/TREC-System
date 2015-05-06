require 'rails_helper'

RSpec.describe Faq, type: :model do
  it "should be valid" do
		expect(Faq.new(:order => 1,
		:question => "this is a question",
		:answer => "this is a long answer")).to be_valid
	end
	
	it "should require order" do
		expect(Faq.new(
		:question => "this is a question",
		:answer => "this is a long answer")).to_not be_valid
	end
	
	it "should require answer" do
		expect(Faq.new(:order => 1,
		:question => "this is a question")).to_not be_valid
	end
	
	it "should require question" do
		expect(Faq.new(:order => 1,
		:answer => "this is a answer")).to_not be_valid
	end
	
	it "should require a positive order number" do
		expect(Faq.new(:order => -1,
		:answer => "this is a answer")).to_not be_valid
	end
end
