Feature: User sign up page
	
	Scenario: Add an username
		Given I'm on the user sign up page
		When I add a new user
		Then I should be able to see the userpage with user signing in

	Scenario: Add an user without username
		Given I'm on the user sign up page
		When I add a new user without username
		Then I can't create an user without username

	Scenario: Add an user without password
		Given I'm on the user sign up page
		When I add a new user without password
		Then I can't create an user without password