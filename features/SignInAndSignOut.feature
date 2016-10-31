Feature: User in the sign in page
		 As a registered user
		 I want to sign in with my username and password


	Scenario: Sign in with username and password
		Given I have set up the user database
			And I'm in the user sign in page
		When I fill the username and password and sign in 
		Then I should be able to sign in successfully ans routes to my user homepage

	Scenario: User sign out
		Given I have set up the user database
			And I sign in with username and password
			And I'm in the user homepage
		When click the sign out
		Then I should be able to sign out and see sign in and sign up link in the page