Feature: Admin Check-in participant

Background: Start from Admin Dashboard
	Given I am on the home page
	Then I should see "Log in"
	When I follow "Log in"
	And I fill in "Email" with "administrator@example.com"
	And I fill in "Password" with "password"
	And I press "Log in"
	Then I should be on the administrator dashboard
	
Scenario: Check-In
	Given I am on the administrator dashboard
	When I follow "Participant Check-In"
	Then I should be on the check in page
	And I should see "Team"
	And I should see "First Name"
	And I should see "Last Name"
	And I should see "Waiver Checklist"	
	
Scenario: Back to Dashboard
	Given I am on the administrator dashboard
	When I follow "Participant Check-In"
	Then I should be on the check in page
	When I follow "Back to Dashboard"
	Then I should be on the administrator dashboard		