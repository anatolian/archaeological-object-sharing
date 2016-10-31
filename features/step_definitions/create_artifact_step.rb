Given (/^I'm on the create model page$/) do
	visit(create_model_path)
end

When (/^I add a new model$/) do
	fill_in 'AftiFact Name', :with => "abc"
	fill_in 'Location', :with => "Pacific Ocean"
	fill_in 'Date Acquired', :with => "1776"
	fill_in 'Info', :with => "123456"
	fill_in 'Picture1', :with => "https://upload....jpg"
	fill_in 'Picture2', :with => "https://upload....jpg"
	click_button "Create Model"
end

Then (/^I should be able to see the result of the created model$/) do
	assert page.has_content?("Artifact Info:")
end