require 'spec_helper'
require 'rails_helper'

feature 'Log in' do
	before(:each) do
	    c = Conference.create!(start_date: Date.parse("2015-4-4"), 
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
  
		team = Team.create!(:conference => c,	
		  :school => "TestSchool",
		  :paid_status => "paid", 
		  :team_name => "PartControllerTest" 
		  )
		p = Participant.create!(captain: false, shirt_size: "M", 
			phone: "1234567890", phone_email: "1234567890@utext.com",
			team: team, account_attributes: {
				first_name: "TestFirst", last_name: "TestLast",
				email: "test@example.com", password: "password",
				password_confirmation: "password"
			})
	end

	scenario 'with valid email and password' do		
		log_in_with('test@example.com', 'password')

		expect(page).to have_content('Log out')	
	end
	
	scenario 'with invalid email' do
		log_in_with('invalid_email', 'password')

		expect(page).to have_content('Log in')	
	end
	
	scenario 'with wrong password' do
		log_in_with('test@example.com', 'wrong_password')

		expect(page).to have_content('Log in')
	end
	
	scenario 'with valid information and then logout' do
		log_in_with('test@example.com', 'password')
		
		Capybara.current_session.driver.delete logout_path
		expect(Capybara.current_session.driver.response).to be_redirect
		visit Capybara.current_session.driver.response.location

		expect(page).to have_content('Home')
	end
	
	def log_in_with(email, password)
		visit login_path
		fill_in 'Email', with: email
		fill_in 'Password', with: password
		click_button 'Log in'
	end
end