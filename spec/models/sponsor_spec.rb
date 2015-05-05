require 'rails_helper'

RSpec.describe Sponsor, type: :model do

	before(:all) do
		@c = Conference.create!(start_date: Date.parse("2015-4-4"), 
			end_date: Date.parse("2015-6-6"),
			conf_start_date: Date.parse("2015-6-8"),
		    conf_end_date: Date.parse("2015-6-9"),
			max_team_size: 6,
			min_team_size: 1,
			max_teams: 5,
			tamu_cost: 30.00,
			other_cost: 60.00,
			challenge_desc: 'yay!',
			)
	end
	
	after(:all) do
		@c.destroy
	end
  
	it "should be valid" do
		expect(Sponsor.new(
			:conference_id => @c.id,
			:sponsor_name => "Test",
			:logo_path => File.new(File.join(Rails.root.join, "app/assets/images/up.gif")),
			:priority => 1
		)).to be_valid
	end

	it "should require conference" do
		expect(Sponsor.new(
			:sponsor_name => "Test",
			:logo_path => File.new(File.join(Rails.root.join, "app/assets/images/up.gif")),
			:priority => 1
		)).to_not be_valid
	end

	it "should require logo path" do
		expect(Sponsor.new(
			:conference_id => @c.id,
			:sponsor_name => "Test",
			:priority => 1
		)).to_not be_valid
	end

	it "should require sponsor name" do
		expect(Sponsor.new(
			:conference_id => @c.id,
			:logo_path => File.new(File.join(Rails.root.join, "app/assets/images/up.gif")),
			:priority => 1
		)).to_not be_valid
	end

	it "should require a priority" do
		expect(Sponsor.new(
			:conference_id => @c.id,
			:sponsor_name => "Test",
			:logo_path => File.new(File.join(Rails.root.join, "app/assets/images/up.gif"))
		)).to_not be_valid
	end

	it "should not allow a priority of 0" do
		expect(Sponsor.new(
			:conference_id => @c.id,
			:sponsor_name => "Test",
			:logo_path => File.new(File.join(Rails.root.join, "app/assets/images/up.gif")),
			:priority => 0
		)).to_not be_valid
	end

	it "should not allow a priority of 4" do
		expect(Sponsor.new(
			:conference_id => @c.id,
			:sponsor_name => "Test",
			:logo_path => File.new(File.join(Rails.root.join, "app/assets/images/up.gif")),
			:priority => 5
		)).to_not be_valid
	end
  
end
