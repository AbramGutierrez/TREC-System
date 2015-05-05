Feature: Participant Edit Team

Background: Start from Participant Dashboard
	Given I am on the home page
	Then I should see "Log in"
	When I follow "Log in"
	And I fill in "Email" with "participant@example.com"
	And I fill in "Password" with "password"
	And I press "Log in"
	Then I should be on the participant dashboard
	
Scenario: Displays Team Info
	Given I am on the participant dashboard
	Then I should be on the team show page
	And I should see "School"	
	And I should see "Team ame"	
	And I should see "Paid status"	
	And I should see "Edit Team Info"	
	And I should see "Add/Remove Team Members"	
	And I should see "Back"	
	
Scenario: Can Go Back to Dashboard
	Given I am on the participant dashboard
	When I follow "Back"
	Then I should be on the participant dashboard