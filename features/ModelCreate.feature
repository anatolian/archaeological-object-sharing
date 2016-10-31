Feature: Create model page
	
	Scenario: Add a model
		Given I'm on the create model page
		When I add a new model
		Then I should be able to see the result of the created model