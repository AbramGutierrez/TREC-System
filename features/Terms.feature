Feature: Terms

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
	
Scenario: Terms index
	Given I am on the home page
	When I follow "Terms"
	Then I should be on the terms page
	And I should see "Terms of Use"
	And I should see "Order"
	And I should see "Title"
	And I should see "Body"
	
Scenario: New Term (happy) and Show Term
	Given I am on the home page
	When I follow "Terms"
	Then I should be on the terms page
	When I follow "New Term"
	Then I should be on the term new page
	When I fill in "Order" with "5"
	And I fill in "Title" with "myTitle"
	And I fill in "Body" with "randomwords"
	And I press "Create Term"
	Then I should be on the term show page
	And I should see "Order"
	And I should see "Title"
	And I should see "Body"
	
Scenario: New Term (sad)
	Given I am on the home page
	When I follow "Terms"
	Then I should be on the terms page
	When I follow "New Term"
	Then I should be on the term new page
	When I fill in "Order" with ""
	And I fill in "Title" with "myTitle"
	And I fill in "Body" with "randomwords"
	And I press "Create Term"
	Then I should be on the terms page	