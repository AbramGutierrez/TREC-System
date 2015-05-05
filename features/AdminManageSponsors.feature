Feature: Admin Manage Sponsors

Background: Start from Admin Dashboard
	Given I am on the home page
	Then I should see "Log in"
	When I follow "Log in"
	And I fill in "Email" with "administrator@example.com"
	And I fill in "Password" with "password"
	And I press "Log in"
	Then I should be on the administrator dashboard
	
Scenario: View Sponsors
	Given I am on the administrator dashboard
	When I follow "Manage Sponsors"
	Then I should be on the sponsors page
	And I should see "Back to Dashboard"
	And I should see "Current Sponsors"
	And I should see "Sponsor Name"
	And I should see "Logo"
	And I should see "Priority"

Scenario: Add Sponsor (happy)
	Given I am on the administrator dashboard
	When I follow "Manage Sponsors"
	Then I should be on the sponsors page
	When I follow "add_sponsor"
	Then I should be on the sponsor new page
	And I should see "Conference start date"
	And I should see "Sponsor name"
	And I should see "Upload logo"
	And I should see "Enter sponsor website url"
	And I should see "Priority"
	# Not sure how to upload an image, probably test with rspec instead	

Scenario: Add Sponsor (sad)
	Given I am on the administrator dashboard
	When I follow "Manage Sponsors"
	Then I should be on the sponsors page
	When I follow "add_sponsor"
	Then I should be on the sponsor new page
	When I fill in "Sponsor name" with "testsponsor"
	And I press "Submit"
	Then I should be on the sponsors page
	And I should see "error"	

Scenario: Back to Dashboard
	Given I am on the administrator dashboard
	When I follow "Manage Sponsors"
	Then I should be on the sponsors page
	When I follow "Back to Dashboard"
	Then I should be on the administrator dashboard		