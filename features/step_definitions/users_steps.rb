Given (/I am on the user page/) do 
	visit users_path
	click_link 'New User'
end

When (/I want to create a user/) do
	fill_in 'Firstname', :with => "Donald"
	fill_in 'Lastname', :with => "Trump"
	fill_in 'Username', :with => "example@upenn.com"
	click_button "Create User"
end

Then (/^I should be able to see the user information$/) do
	assert page.has_content?("User was successfully created")
end

When (/I want to edit the created user/) do
	fill_in 'Firstname', :with => "Donald"
	fill_in 'Lastname', :with => "Trump"
	fill_in 'Username', :with => "example@upenn.com"
	click_button "Create User"
	click_link 'Edit'
end

Then (/^I should be able to see the editing page$/) do
	assert page.has_content?("Editing User")
end