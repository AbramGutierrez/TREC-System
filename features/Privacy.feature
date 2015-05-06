Feature: Privacy

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
	
Scenario: Privacy index
	Given I am on the home page
	When I follow "Privacy"
	Then I should be on the privacies page
	And I should see "Privacy Policy"
	And I should see "Order"
	And I should see "Title"
	And I should see "Body"