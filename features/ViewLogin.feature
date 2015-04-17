Feature: User Login

Scenario: View Login
	Given I am on the home page
	When I follow "Log in"
	Then I should be on the Log in page
	And I should see "Log in"
	And I should see "Email"
	And I should see "Password"
	
Scenario: Login
	Given I am on the home page
    When I follow "Log in"
	Then I should be on the Log in page
	When I fill in "Email" with "participant@example.com"
	And I fill in "Password" with "password"
	And I press "Log in"
	Then I should be on the home page
	And I should see "Log out"
	
Scenario: Logout
	Given I am on the home page
    When I follow "Log in"
	Then I should be on the Log in page
	When I fill in "Email" with "participant@example.com"
	And I fill in "Password" with "password"
	And I press "Log in"
	Then I should be on the home page
	When I follow "Log out"
	Then I should be on the home page
	And I should see "Log in"