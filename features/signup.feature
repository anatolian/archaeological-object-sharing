Feature: User sign up page
	
	Scenario: user sign up
		Given I'm on the user sign up page
		When I add a new user
		Then I should be able to see the log in page

	Scenario: Add an user without email
		Given I'm on the user sign up page
		When I add a new user without email
		Then I can't create an user without email

	Scenario: Add an user without short password
		Given I'm on the user sign up page
		When I add a new user with short password
		Then I can't create an user with short password