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
	When I enter test@example.com to Email
	And I enter password to Password
	Then I should be on the home page
	And I should see "Logout"
	
Scenario: Logout
	Given I am on the home page
    When I follow "Log in"
	Then I should be on the Log in page
	When I enter test@example.com to Email
	And I enter password to Password
	Then I should be on the home page
	When I follow "Logout"
	Then I should be on the home page
	And I should see "Log in"