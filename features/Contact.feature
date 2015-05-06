Feature: Contact Info

Background: Log in
	Given I am on the home page
	Then I should see "Log in"
	When I follow "Log in"
	And I fill in "Email" with "administrator@example.com"
	And I fill in "Password" with "password"
	And I press "Log in"
	Then I should be on the administrator dashboard
	When I follow "Home"
	Then I should be on the home page
	
Scenario: Contact Info index
	Given I am on the home page
	When I follow "Contact"
	Then I should be on the contacts page
	And I should see "Rank"
	And I should see "Group"
	And I should see "Position"
	And I should see "Name"
	And I should see "Email"
	And I should see "Other"