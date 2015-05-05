Feature: Send notification
	In order to give information
	An admin
	Should send participants a message by email
	
	Background: Start from Administrator page
		Given I am on the home page
		Then I should see "Log in"
		When I follow "Log in"
		And I fill in "Email" with "administrator@example.com"
		And I fill in "Password" with "password"
		And I press "Log in"
		Then I should be on the administrator dashboard
		When I follow "Send Notifications"
		Then I should be on the send message page
	
	Scenario: Sends an email to all participants (happy)
		When I choose "All Participants"
		And I fill in "Title" with "Welcome, Everyone!"
		And I fill in "Message" with "Hello, everyone! We will meet tomorrow at 9:00 pm in Koldus 110. I hope to see all of you there and happy. Please bring an extra pair of shoes. I hear it will rain tomorrow!"
		And I press "Submit"
		Then I should be on the message success page
		And I should see "You sent the following message to all participants via email."
		And I should see "Title: Welcome, Everyone!"
		And I should see "Message: Hello, everyone! We will meet tomorrow at 9:00 pm in Koldus 110. I hope to see all of you there and happy. Please bring an extra pair of shoes. I hear it will rain tomorrow!"
		
	Scenario: Sends an email to all participants (sad)
		When I choose "All Participants"
		And I fill in "Title" with "Welcome, Everyone!"
		And I fill in "Message" with "Hello, everyone! We will meet tomorrow at 9:00 pm in Koldus 110."
		And I press "Submit"
		Then I should be on the message failure page
		And I should see "There was an error in sending the following email to all participants."
		And I should see "Title: Welcome, Everyone!"
		And I should see "Message: Hello, everyone! We will meet tomorrow at 9:00 pm in Koldus 110."
		
	Scenario: Sends a text message to all captains (happy)
		When  I choose "Text Messaging"
		And I fill in "Title" with "Welcome, Everyone!"
		And I fill in "Message" with "Hello, everyone! We will meet tomorrow at 9:00 pm in Koldus 110."
		And I press "Submit"
		Then I should be on the message failure page
		And I should see "You sent the following message to all captains via text message."
		And I should see "Title: Welcome, Everyone!"
		And I should see "Message: Hello, everyone! We will meet tomorrow at 9:00 pm in Koldus 110."
		
	Scenario: Sends a text message to all captains (sad)
		When I choose "Text Messaging"
		And I fill in "Title" with "Welcome, Everyone!"
		And I fill in "Message" with "Hello, everyone! We will meet tomorrow at 9:00 pm in Koldus 110. I hope to see all of you there and happy. Please bring an extra pair of shoes. I hear it will rain tomorrow!"
		And I press "Submit"
		Then I should be on the send message page
		And I should see "Your text message exceeded 160 characters and was not sent. Please modify or send an email."
		And I should see "Welcome, Everyone!" in "Title"
		And I should see "Hello, everyone! We will meet tomorrow at 9:00 pm in Koldus 110. I hope to see all of you there and happy. Please bring an extra pair of shoes. I hear it will rain tomorrow!" in "Message"
		
	Scenario: Sends a text message to all captains (happy)
		When I choose "Text Messaging"
		And I fill in "Title" with "Welcome, Everyone!"
		And I fill in "Message" with "Hello, everyone! We will meet tomorrow at 9:00 pm in Koldus 110."
		And I press "Submit"
		Then I should be on the message failure page
		And I should see "There was an error in sending the following text message to all captains."
		And I should see "Title: Welcome, Everyone!"
		And I should see "Message: Hello, everyone! We will meet tomorrow at 9:00 pm in Koldus 110."