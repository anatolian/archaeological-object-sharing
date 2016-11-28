Feature: As a registered user I want to log in with my username and password

	Scenario: Sign in with username and password
		Given I am a registered user
			And I go to log in page
		When I sign in with username and password
		Then I should be able to sign in successfully

	Scenario: User sign out
		Given I am a registered user
			And I am in the user home page
		When I click the sign out link
		Then I should be able to sign out and see sign in page again