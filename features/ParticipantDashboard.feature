Feature: Participant Dashboard features

Background: Start from Participant Dashboard
	Given I am on the home page
	Then I should see "Log in"
	When I follow "Log in"
	And I fill in "Email" with "participant@example.com"
	And I fill in "Password" with "password"
	And I press "Log in"
	Then I should be on the participant dashboard

Scenario: Dashboard Options
	Given I am on the participant dashboard
	Then I should see "Conference Information"
	And I should see "Team Information"
	And I should see "Manage Account"
	
Scenario: Conference Information
	Given I am on the participant dashboard
	When I follow "Conference Information"
	Then I should be on the conference show page

Scenario: Team Information
	Given I am on the participant dashboard
	When I follow "Team Information"
	Then I should be on the team show page

Scenario: Manage Account
	Given I am on the participant dashboard
	When I follow "Manage Account"
	Then I should be on the participant show page	