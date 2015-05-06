Feature: FAQs

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
	When I follow "FAQ"
	Then I should be on the faqs page
	And I should see "Order"
	And I should see "Question"
	And I should see "Answer"