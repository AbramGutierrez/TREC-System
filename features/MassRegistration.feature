Feature: Mass Registration

Background: Start on register page
	Given I am on the home page
	Then I should see "Register"
	When I follow "Register"
	Then I should be on the register page

Scenario: Correct Information on Register Page
	Given I am on the register page
	And I should see "Mass Registration"
	And I should see "School Name"
	And I should see "Team Name"
	And I should see "Role"
	And I should see "Phone Number"
	And I should see "Phone Provider"
	And I should see "Shirt Size"
	And I should see "First Name"
	And I should see "Last Name"
	And I should see "Email"
	
Scenario: Good input on register page
	Given I am on the register page
	When I fill in "Team Name" with "CucTestTeam"
	And I fill in "Phone Number" with "1234567890"
	And I fill in "Phone Provider" with "AT&T"
	And I fill in "First Name" with "firstTest"
	And I fill in "Last Name" with "lastTest"
	And I fill in "Email" with "cucTesting@test.com"
	And I press "Submit"
	Then I should be on the Log in page
	
Scenario: Bad input on register page
	Given I am on the register page
	When I fill in "Team Name" with "CucTestTeam"
	And I fill in "Phone Number" with "1234567890"
	And I fill in "Phone Provider" with "AT&T"
	And I fill in "First Name" with "firstTest"
	And I fill in "Last Name" with "lastTest"
	And I fill in "Email" with "bad email"
	And I press "Submit"
	Then I should be on the register page
	And I should see "error"