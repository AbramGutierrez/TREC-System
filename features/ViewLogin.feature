Feature: User can go to the Login page

Scenario: View Login
	Given I am on the home page
	When I follow "Log in"
	Then I should be on the Log in page
	And I should see "Log in"
	And I should see "Email"
	And I should see "Password"