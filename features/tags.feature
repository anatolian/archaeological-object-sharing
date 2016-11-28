Feature: As a user I want to go to the tag page and fill in my locations

	Scenario: create tag
		Given I have signed in and I am in the user page already
			And I am in the tags page
		When I want to create a tag
		Then I should be able to see the tag information created

	Scenario: Not to create a new tag
		Given I have signed in and I am in the user page already
			And I am in the tags page
		When I decide not to create a new tag
		Then I will go back to tag listing page

	Scenario: Create tag incorrectly
		Given I have signed in and I am in the user page already
			And I am in the tags page
		When I create a tag without description
		Then I will still have a successfully created tag