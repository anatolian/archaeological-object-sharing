Feature: As a user I want to create user account

	Scenario: Create new user
	Given I am on the user page
	When I want to create a user
	Then I should be able to see the user information

	Scenario: Not to create a new location
	Given I am on the user page
	When I want to edit the created user
	Then I should be able to see the editing page