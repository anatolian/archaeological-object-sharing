Feature: As a user I want to go to the location page and fill in my locations

	Scenario: Create new location
	Given I am on the locations page
	When I want to create a location
	Then I should be able to see the location information created

	Scenario: Not to create a new location
	Given I am on the locations page
	When I decide not to create a new location
	Then I will go back to location listing page

	Scenario: Not to create a new location
	Given I am on the locations page
	When I create a location without description
	Then I will still have a successfully created location
