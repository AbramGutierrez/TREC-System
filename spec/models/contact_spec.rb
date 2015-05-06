require 'rails_helper'

RSpec.describe Contact, type: :model do
    it "should be valid" do
		expect(Contact.new(:rank => 1, 
			:group => "group", 
			:position => "position", 
			:name => "name", 
			:email => "email")).to be_valid
	end
	
	it "should require rank" do
		expect(Contact.new( 
			:group => "group", 
			:position => "position", 
			:name => "name", 
			:email => "email")).to_not be_valid
	end
	
	it "should require group" do
		expect(Contact.new(:rank => 1, 
			:group => "", 
			:position => "position", 
			:name => "name", 
			:email => "email")).to_not be_valid
	end
	
	it "should require position" do
		expect(Contact.new(:rank => 1, 
			:group => "group", 
			:position => "", 
			:name => "name", 
			:email => "email")).to_not be_valid
	end
	
	it "should require name" do
		expect(Contact.new(:rank => 1, 
			:group => "group", 
			:position => "position", 
			:name => "", 
			:email => "email")).to_not be_valid
	end
	
	it "should require email" do
		expect(Contact.new(:rank => 1, 
			:group => "group", 
			:position => "position", 
			:name => "name", 
			:email => "")).to_not be_valid
	end
	
	it "should require a positive rank number" do
		expect(Contact.new(:rank => -1, 
			:group => "group", 
			:position => "position", 
			:name => "name", 
			:email => "email")).to_not be_valid
	end
end
