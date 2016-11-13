Feature: As a user I want to create groups

	Scenario: Create new group
	Given I am on the groups page
	When I want to create a group
	Then I should be able to see the group name

	Scenario: Not to create a new group
	Given I am on the groups page
	When I decide not to create a new group
	Then I will go back to groups creating page