Feature: As a user I want to create user account

	Scenario: See the user profile
	Given I am in the my own user page
		And I am on the user page
	When I want to see the created user
	Then I should be able to see the user information

	Scenario: Switch between my own profile and users listing page
	Given I am in the my own user page
		And I am on the user page
	When I leave from my profile page
	Then I should be able to see the users listing page