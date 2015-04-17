Feature: Administrator can add new conference

Background: Start from Administrator page
	Given I am on the home page
	Then I should see "Log in"
	When I follow "Log in"
	And I fill in "Email" with "administrator@example.com"
	And I fill in "Password" with "password"
	And I press "Log in"
	Then I should be on the Administrator page
	
Scenario: Add new conference (happy)
	When I follow "Create New Conference"
	And I fill in "Start date" with "4/8/2015"
	And I fill in "End date" with "4/10/2015"
	And I fill in "Max team size" with "6"
	And I fill in "Min team size" with "6"
	And I fill in "Max teams" with "25"
	And I fill in "TAMU cost" with "30.00"
	And I fill in "Other cost" with "30.00"
	And I fill in "Challenge desc" with "Some challenge info"
	And I press "Create Conference"
	Then I should be on Conference Information page
	