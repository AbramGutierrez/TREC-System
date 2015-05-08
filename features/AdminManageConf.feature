Feature: Admin Manage Conferences

Background: Start from Admin Dashboard
	Given I am on the home page
	Then I should see "Log in"
	When I follow "Log in"
	And I fill in "Email" with "administrator@example.com"
	And I fill in "Password" with "password"
	And I press "Log in"
	Then I should be on the administrator dashboard
	
Scenario: View Conferences
	Given I am on the administrator dashboard
	When I follow "Manage Conferences"
	Then I should be on the conferences page
	And I should see "Back to Dashboard"
	And I should see "Conferences"
	And I should see "Registration"
	And I should see "Conference Dates"
	And I should see "Team Size"
	And I should see "Max Teams"
	And I should see "Tamu Cost"
	And I should see "Other Cost"
	And I should see "Challenge Desc"
	And I should see "Active?"
	
Scenario: Add Conference(happy)
	Given I am on the administrator dashboard
	When I follow "Manage Conferences"
	Then I should be on the conferences page
	When I follow "add_conference"
	Then I should be on the conference new page
	When I fill in "Max team size" with "10"
	And I fill in "Min team size" with "1"
	And I fill in "Max teams" with "25"
	And I fill in "Tamu cost" with "20"
	And I fill in "Other cost" with "0"
	And I fill in "Challenge desc" with "fun times"
	And I press "Submit"
	Then I should see "success"	
	
Scenario: Add Conference(sad)
	Given I am on the administrator dashboard
	When I follow "Manage Conferences"
	Then I should be on the conferences page
	When I follow "add_conference"
	Then I should be on the conference new page
	When I fill in "Max team size" with ""
	And I fill in "Min team size" with "1"
	And I fill in "Max teams" with "25"
	And I fill in "Tamu cost" with "20"
	And I fill in "Other cost" with "0"
	And I fill in "Challenge desc" with "fun times"
	And I press "Submit"
	Then I should be on the conferences page
	And I should see "error"	
	
Scenario: View Conference Info
	Given I am on the administrator dashboard
	When I follow "Manage Conferences"
	Then I should be on the conferences page
	When I follow "view1"
	Then I should see "Registration Start Date"
	And I should see "Registration End Date"	
	And I should see "Conference Start Date"	
	And I should see "Conference End Date"	
	And I should see "Team Size"	
	And I should see "Maximum Teams"	
	And I should see "TAMU Student Cost"	
	And I should see "Other School Cost"	
	And I should see "Challenge Description"
	And I should see "Update Conference"
	And I should see "Back"

Scenario: Edit Conference (happy)
	Given I am on the administrator dashboard
	When I follow "Manage Conferences"
	Then I should be on the conferences page
	When I follow "update1"
	Then I should be on the conference edit page 	
	When I fill in "Max team size" with "10"
	And I press "Submit"
	Then I should be on the conference show page

Scenario: Edit Conference (sad)
	Given I am on the administrator dashboard
	When I follow "Manage Conferences"
	Then I should be on the conferences page
	When I follow "update1"
	Then I should be on the conference edit page 
	When I fill in "Max team size" with "1"
	And I fill in "Min team size" with "20"
	And I press "Submit"
	Then I should see "error"
	And I should be on the conference show page	
	
Scenario: Back to Dashboard
	Given I am on the administrator dashboard
	When I follow "Manage Conferences"
	Then I should be on the conferences page
	When I follow "Back to Dashboard"
	Then I should be on the administrator dashboard		