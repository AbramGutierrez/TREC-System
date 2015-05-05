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
	When I follow "Team Information"
	Then I should be on the team show page
	And I should see "School"	
	And I should see "Team name"	
	And I should see "Paid status"	
	And I should see "Edit Team Info"	
	And I should see "Add/Remove Team Members"	
	And I should see "Back"	
	
Scenario: Edit Team Info(happy)
	Given I am on the participant dashboard
	When I follow "Team Information"
	Then I should be on the team show page
	When I follow "Edit Team Info"
	Then I should be on the team edit page
	When I fill in "Team name" with "testTeam1"
	And I press "Update Team"
	Then I should be on the team show page
	
Scenario: Edit Team Info(sad)
	Given I am on the participant dashboard
	When I follow "Team Information"
	Then I should be on the team show page
	When I follow "Edit Team Info"
	Then I should be on the team edit page
	When I fill in "Team name" with ""
	And I press "Update Team"
	Then I should be on the team invalid edit page
	And I should see "Team name can't be blank"

Scenario: Add/Remove Team Members
	Given I am on the participant dashboard
	When I follow "Team Information"
	Then I should be on the team show page
	When I follow "Add/Remove Team Members"
	Then I should be on the team members page
	And I should see "Abram Gutierrez"
	And I should see "Add new team member"
	And I should see "Back"
	When I follow "Back"
	Then I should be on the team show page
	
Scenario: Add Team Members(happy)
	Given I am on the participant dashboard
	When I follow "Team Information"
	Then I should be on the team show page
	When I follow "Add/Remove Team Members"
	Then I should be on the team members page
	When I follow "Add new team member"
	Then I should be on the participant new page
	When I fill in "First name" with "TestFirst"
	And I fill in "Last name" with "TestLast"
	And I fill in "Email" with "cuctest78787@test.com"
	And I fill in "Password" with "password"
	And I fill in "Password confirmation" with "password"
	And I fill in "Phone" with "1111111111"
	And I fill in "Phone provider" with "AT&T"
	And I press "Create Participant"
	Then I should be on the team members page
	
Scenario: Add Team Members(sad)
	Given I am on the participant dashboard
	When I follow "Team Information"
	Then I should be on the team show page
	When I follow "Add/Remove Team Members"
	Then I should be on the team members page
	When I follow "Add new team member"
	Then I should be on the participant new page
	When I fill in "First name" with "TestFirst"
	And I fill in "Last name" with "TestLast"
	And I fill in "Email" with ""
	And I fill in "Password" with "password"
	And I fill in "Password confirmation" with "password"
	And I fill in "Phone" with "1111111111"
	And I fill in "Phone provider" with "AT&T"
	And I press "Create Participant"
	Then I should be on the participants page
	And I should see "Account email can't be blank"	
	
Scenario: Can Go Back to Dashboard
	Given I am on the participant dashboard
	When I follow "Team Information"
	Then I should be on the team show page
	When I follow "Back"
	Then I should be on the participant dashboard