Feature: Participant View Conference Info

Background: Start from Participant Dashboard
	Given I am on the home page
	Then I should see "Log in"
	When I follow "Log in"
	And I fill in "Email" with "participant@example.com"
	And I fill in "Password" with "password"
	And I press "Log in"
	Then I should be on the participant dashboard
	
Scenario: View Conference Info
	Given I am on the participant dashboard
	When I follow "Conference Information"
	Then I should be on the conference show page
	And I should see "Registration Start Date"
	And I should see "Registration End Date"
	And I should see "Conference Start Date"
	And I should see "Conference End Date"
	And I should see "Team Size"
	And I should see "Maximum Teams"
	And I should see "Challenge Description"
	
Scenario: Go back to Participant Dashboard
	Given I am on the participant dashboard
	When I follow "Conference Information"
	Then I should be on the conference show page
	When I follow "Back"
	Then I should be on the participant dashboard