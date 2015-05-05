Feature: Admin Dashboard features

Background: Start from Administrator page
	Given I am on the home page
	Then I should see "Log in"
	When I follow "Log in"
	And I fill in "Email" with "administrator@example.com"
	And I fill in "Password" with "password"
	And I press "Log in"
	Then I should be on the administrator dashboard
	
Scenario: Dashboard Options
	Given I am on the administrator dashboard
	Then I should see "Send Notifications"
	And I should see "Manage Teams"
	And I should see "Manage Conferences"
	And I should see "Manage Sponsors"
	And I should see "Manage Schools"
	
Scenario: Send Notifications
	Given I am on the administrator dashboard
	When I follow "Send Notifications"
	Then I should be on the send message page	
	
Scenario: Manage Teams
	Given I am on the administrator dashboard
	When I follow "Manage Teams"
	Then I should be on the teams page
	
Scenario: Manage Conferences
	Given I am on the administrator dashboard
	When I follow "Manage Conferences"
	Then I should be on the conferences page

Scenario: Manage Sponsors
	Given I am on the administrator dashboard
	When I follow "Manage Sponsors"
	Then I should be on the sponsors page

Scenario: Manage Schools
	Given I am on the administrator dashboard
	When I follow "Manage Schools"
	Then I should be on the schools page	