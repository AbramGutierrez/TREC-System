Feature: Admin Manage Schools

Background: Start from Admin Dashboard
	Given I am on the home page
	Then I should see "Log in"
	When I follow "Log in"
	And I fill in "Email" with "administrator@example.com"
	And I fill in "Password" with "password"
	And I press "Log in"
	Then I should be on the administrator dashboard
	
Scenario: View Schools
	Given I am on the administrator dashboard
	When I follow "Manage Schools"
	Then I should be on the schools page
	And I should see "Schools"
	And I should see "Name"
	And I should see "Back to Dashboard"
	
Scenario: Add School (happy)
	Given I am on the administrator dashboard
	When I follow "Manage Schools"
	Then I should be on the schools page
	When I follow "add_school"
	Then I should be on the school new page
	And I should see "Name"
	When I fill in "Name" with "schoolfortest"
	And I press "Submit"
	Then I should be on the schools page

Scenario: Add School (sad)
	Given I am on the administrator dashboard
	When I follow "Manage Schools"
	Then I should be on the schools page
	When I follow "add_school"
	Then I should be on the school new page
	And I should see "Name"
	When I fill in "Name" with ""
	And I press "Submit"
	Then I should see "error"
	And I should be on the schools page	
	
Scenario: View School Info	
	Given I am on the administrator dashboard
	When I follow "Manage Schools"
	Then I should be on the schools page
	When I follow "view1"
	Then I should be on the school show page
	And I should see "Name"
	When I follow "School List"
	Then I should be on the schools page

Scenario: Edit School (happy)
	Given I am on the administrator dashboard
	When I follow "Manage Schools"
	Then I should be on the schools page
	When I follow "update1"
	Then I should be on the school edit page
	When I fill in "Name" with "testingschool959595"
	And I press "Submit"
	Then I should be on the schools page	
	
Scenario: Edit School (sad)
	Given I am on the administrator dashboard
	When I follow "Manage Schools"
	Then I should be on the schools page
	When I follow "update1"
	Then I should be on the school edit page
	When I fill in "Name" with ""
	And I press "Submit"
	Then I should see "error"
	And I should be on the school invalid edit page	
	
Scenario: Back to Dashboard
	Given I am on the administrator dashboard
	When I follow "Manage Schools"
	Then I should be on the schools page
	When I follow "Back to Dashboard"
	Then I should be on the administrator dashboard	