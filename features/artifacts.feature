Feature: As a user I want to create artifacts

	Scenario: Create new artifact
	Given I am loged in and I am in the user page already
		And I am on the artifacts page
	When I want to create a artifact
	Then I should be able to see the artifact information

	Scenario: Not to create a new artifact
	Given I am loged in and I am in the user page already
		And I am on the artifacts page
	When I decide not to create artifacts
	Then I will go back to artifacts listing page