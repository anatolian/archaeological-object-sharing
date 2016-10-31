Feature: Login page
		 As a user
		 I want to log in with my username(email) and password

	Scenario: log in with username and password
		Given I have a user account
			And I'm in the user login page
		When I fill the username and password and log in 
		Then I should be able to log in successfully and go to my user homepage

	Scenario: go to the create_account page
		Given I'm in the user login page
		When I do not have a user account
		Then I will go to signup page