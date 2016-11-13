Given (/I am on the artifacts page/) do 
	visit artifacts_path
	click_link 'New Artifact'
end

When (/I want to create a artifact/) do
	fill_in 'Name', :with => "an artifact with no name"
	fill_in 'Description', :with => "Is this really an artifact?"
	fill_in 'Coordinate', :with => "11.11"
	click_button "Create Artifact"
end

Then (/^I should be able to see the artifact information$/) do
	assert page.has_content?("Artifact was successfully created")
end

When (/I decide not to create artifacts/) do 
	click_link "Back"
end

Then (/I will go back to artifacts listing page/) do
	assert page.has_content?("Listing Artifacts") 
end