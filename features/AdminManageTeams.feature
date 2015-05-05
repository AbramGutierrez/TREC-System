Feature: Admin Manage Teams

Background: Start from Admin Dashboard
	Given I am on the home page
	Then I should see "Log in"
	When I follow "Log in"
	And I fill in "Email" with "administrator@example.com"
	And I fill in "Password" with "password"
	And I press "Log in"
	Then I should be on the administrator dashboard
	
Scenario: Add Team (happy)
	Given I am on the administrator dashboard
	When I follow "Manage Teams"
	Then I should be on the teams page
	When I follow "add_team"
	Then I should be on the team new page
	And I should see "Team name"
	And I should see "Paid status"
	And I should see "School"
	When I fill in "Team name" with "TestTeam19284384"
	And I fill in "Paid status" with "unpaid"
	And I press "Submit"
	Then I should be on the teams page
	
Scenario: Add Team (sad)
	Given I am on the administrator dashboard
	When I follow "Manage Teams"
	Then I should be on the teams page
	When I follow "add_team"
	Then I should be on the team new page
	And I should see "Team name"
	And I should see "Paid status"
	And I should see "School"
	When I fill in "Team name" with ""
	And I fill in "Paid status" with "unpaid"
	And I press "Submit"
	Then I should be on the teams page
	And I should see "error"

Scenario: View Team
	Given I am on the administrator dashboard
	When I follow "Manage Teams"
	Then I should be on the teams page
	When I follow "view1"
	Then I should be on the team show page
	And I should see "Team name"
	And I should see "Paid status"
	And I should see "School"
	And I should see "Update Team Info"
	And I should see "Add/Remove Team Members"
	And I should see "Back"
	
Scenario: Update Team
	Given I am on the administrator dashboard
	When I follow "Manage Teams"
	Then I should be on the teams page
	When I follow "view1"
	Then I should be on the team show page
	When I follow "Update Team Info"
	Then I should be on the team edit page	
	
Scenario: View Team Members
	Given I am on the administrator dashboard
	When I follow "Manage Teams"
	Then I should be on the teams page
	When I follow "view1"
	Then I should be on the team show page
	When I follow "Add/Remove Team Members"
	Then I should be on the team members page
	And I should see "Edit"
	And I should see "Remove"
	And I should see "Add new team member"
	And I should see "Back"	
	
Scenario: View all participants	
	Given I am on the administrator dashboard
	When I follow "Manage Teams"
	Then I should be on the teams page
	When I follow "View all Participants"
	Then I should be on the participants page
	And I should see "Team List"
	And I should see "Back to Dashboard"
	
Scenario: Back to Dashboard
	Given I am on the administrator dashboard
	When I follow "Manage Teams"
	Then I should be on the teams page
	When I follow "Back to Dashboard"
	Then I should be on the administrator dashboard	