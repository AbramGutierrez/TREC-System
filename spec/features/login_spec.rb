require 'spec_helper'
require 'rails_helper'

feature 'Log in' do
	before(:each) do
		p = Participant.create(captain: false, shirt_size: "Medium", 
			phone: 1234567890)
		Account.create(first_name: "TestFirst", last_name: "TestLast",
			email: "test@example.com", password: "password",
			password_confirmation: "password", user: p)
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
		Capybara.current_session.driver.response.should be_redirect
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