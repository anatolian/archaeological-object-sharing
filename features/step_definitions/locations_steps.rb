Given (/I am on the locations page/) do 
	visit locations_path
	click_link 'New Location'
end

When (/I want to create a location/) do
	fill_in 'Name', :with => "xyz"
	fill_in 'Description', :with => "this is a description for a new location"
	fill_in 'Coordinate', :with => "11.11"
	click_button "Create Location"
end

Then (/^I should be able to see the location information created$/) do
	assert page.has_content?("Location was successfully created")
end

When (/I decide not to create a new location/) do 
	click_link "Back"
end

Then (/I will go back to location listing page/) do
	assert page.has_content?("Listing Locations") 
end

When (/I create a location without description/) do 
	fill_in 'Name', :with => "Tom"
	fill_in 'Coordinate', :with => "123.123"
	click_button "Create Location"
end

Then (/^I will still have a successfully created location$/) do
	assert page.has_content?("Location was successfully created")
end
 
