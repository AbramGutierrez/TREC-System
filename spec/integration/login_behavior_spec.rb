require 'rails_helper'

RSpec.describe "login_behavior", :type => :request do
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
		  is_active: true
		  )
	  
		@team = Team.create!(:conference => @c,	
		  :school => "TestSchool",
		  :paid_status => "paid", 
		  :team_name => "ControllerTest" 
		  )
		@p = Participant.create!(captain: false, shirt_size: "L",
			phone: "1876543211", team: @team, account_attributes: {first_name: "A", last_name: "Z", email: "p@example.com",
			password: "password", password_confirmation: "password"}) 

		@admin = Administrator.create!(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin@example.com",
			password: "password", password_confirmation: "password"})		
	end
	
	after(:all) do
		@admin.destroy
	    @p.destroy
		@team.destroy
		@c.destroy
	end
	
	it 'allows the admin to log in' do
	    log_in_as(@admin.account)
	    expect(response).to redirect_to(admin_dashboard_url)
	end
	
	it 'allows the participant to log in' do
		log_in_as(@p.account)
		expect(response).to redirect_to(participant_dashboard_url)
	end
	describe "once the conference is inactive" do
		before(:all) do
			@c.is_active = false
			@c.save!
		end
		
		after(:all) do
			@c.is_active = true
			@c.save!
		end
	
		it 'still allows the admin to log in once the conference is inactive' do
			log_in_as(@admin.account)
			expect(@c.is_active).to eq(false)
			expect(response).to redirect_to(admin_dashboard_url)
		end
		
		it 'does not allow the participant to log in once the conference is inactive' do
			log_in_as(@p.account)
			expect(@c.is_active).to eq(false)
			expect(flash).to_not be_nil
			expect(response).to_not redirect_to(participant_dashboard_url)
		end
	end
	
	describe "once a new conference is created" do
		before(:all) do
			@c2 = Conference.create!(start_date: Date.parse("2015-4-4"), 
			  end_date: Date.parse("2015-6-6"),
			  conf_start_date: Date.parse("2015-6-8"),
			  conf_end_date: Date.parse("2015-6-9"),
			  max_team_size: 6,
			  min_team_size: 1,
			  max_teams: 5,
			  tamu_cost: 30.00,
			  other_cost: 60.00,
			  challenge_desc: 'yay!',
			  is_active: true
			  )
		  
			@team2 = Team.create!(:conference => @c2,	
			  :school => "TestSchool",
			  :paid_status => "paid", 
			  :team_name => "ControllerTest2" 
			  )
			@p2 = Participant.create!(captain: false, shirt_size: "L",
				phone: "1876543211", team: @team2, account_attributes: {first_name: "A", last_name: "Z", email: "p2@example.com",
				password: "password", password_confirmation: "password"})
		end
		
		after(:all) do
			@p2.destroy
			@team2.destroy
			@c2.destroy
		end
		
		it 'still allows the admin to log in once the new conference is created' do
			log_in_as(@admin.account)
			expect(response).to redirect_to(admin_dashboard_url)
		end
		
		it 'does not allow the participant from the old conference to log in' do
			log_in_as(@p.account)
			expect(flash).to_not be_nil
			expect(response).to_not redirect_to(participant_dashboard_url)
		end
		
		it 'allows the new participant to log in' do
			log_in_as(@p2.account)
			expect(response).to redirect_to(participant_dashboard_url)
		end
		
		it 'allows the email of the old participant to be used for a new account' do
			p3 = Participant.new(captain: false, shirt_size: "L",
			phone: "1876543211", team: @team2, account_attributes: {first_name: "A", last_name: "Z", email: "p@example.com",
			password: "password", password_confirmation: "password"})
			
			expect(p3).to be_valid
			p3.save!
			log_in_as(p3.account)
			expect(response).to redirect_to(participant_dashboard_url)
		end
		
		it 'does not allow a participant to use an admins email' do
			p4 = Participant.new(captain: false, shirt_size: "L",
			phone: "1876543211", team: @team2, account_attributes: {first_name: "A", last_name: "Z", email: "admin@example.com",
			password: "password", password_confirmation: "password"})
			
			expect(p4).to_not be_valid
		end
		
		it 'does not allow a participant to use another participants email from the same conference' do
			p4 = Participant.new(captain: false, shirt_size: "L",
			phone: "1876543211", team: @team2, account_attributes: {first_name: "A", last_name: "Z", email: "p2@example.com",
			password: "password", password_confirmation: "password"})
			
			expect(p4).to_not be_valid
		end
		
		it 'allows the creation of a new admin account' do
			expect(Administrator.new(account_attributes: {first_name: "Admin", last_name: "istrator", email: "admin2@example.com",
				password: "password", password_confirmation: "password"}
			)).to be_valid
		end
	end
end