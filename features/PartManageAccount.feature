Feature: Participant Manage Account

Background: Start from Participant Dashboard
	Given I am on the home page
	Then I should see "Log in"
	When I follow "Log in"
	And I fill in "Email" with "participant@example.com"
	And I fill in "Password" with "password"
	And I press "Log in"
	Then I should be on the participant dashboard
	
Scenario: Displays proper info
	Given I am on the participant dashboard
	When I follow "Manage Account"
	Then I should be on the participant show page
	And I should see "Conference Start Date"	
	And I should see "Conference End Date"	
	And I should see "Team"	
	And I should see "First Name"	
	And I should see "Last Name"	
	And I should see "Is Captain?"	
	And I should see "Waiver signed?"	
	And I should see "Shirt size"	
	And I should see "Email"	
	And I should see "Phone Number"
	And I should see "Edit"
	And I should see "Back"	
	
Scenario: Edit Info(happy)
	Given I am on the participant dashboard
	When I follow "Manage Account"
	Then I should be on the participant show page
	When I follow "Edit"
	Then I should be on the participant edit page
	When I fill in "First name" with "Abram"	
	And I fill in "Last name" with "Gutierrez"
	And I fill in "Email" with "participant@example.com"
	And I fill in "Password" with "password"
	And I fill in "Password confirmation" with "password"
	And I fill in "Phone" with "1876543211"
	And I press "Update Participant"
	Then I should be on the participant show page	
	
Scenario: Edit Info(sad)
	Given I am on the participant dashboard
	When I follow "Manage Account"
	Then I should be on the participant show page
	When I follow "Edit"
	Then I should be on the participant edit page
	When I fill in "First name" with "Abram"	
	And I fill in "Last name" with "Gutierrez"
	And I fill in "Email" with "bad_email"
	And I fill in "Password" with "password"
	And I fill in "Password confirmation" with "password"
	And I fill in "Phone" with "1876543211"
	And I press "Update Participant"
	Then I should see "Account email is invalid"
	And I should be on the participant invalid edit page	
	
Scenario: Back to dashboard
	Given I am on the participant dashboard
	When I follow "Manage Account"
	Then I should be on the participant show page
	When I follow "Back"
	Then I should be on the participant dashboard	