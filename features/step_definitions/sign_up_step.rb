Given (/^I'm on the user sign up page$/) do
	visit(create_account_path)
end

When (/^I add a new user$/) do
	fill_in 'Email', :with => "xyz@seas.upenn.edu"
	fill_in 'Password', :with => "123456"
	fill_in 'Confirm Password', :with => "123456"
	click_button "Create Account"
end

Then (/^I should be able to see the userpage with user signing in$/) do
	assert page.has_content?("Welcome to Artifact3D!")
end

When (/^I add a new user without username$/) do
	fill_in 'Password', :with => "123456"
	fill_in 'Password confirmation', :with => "123456"
	click_button "Sign up"
end

Then (/^I can't create an user without username$/) do
	assert page.has_content?("Username can't be empty")
end

When (/^I add a new user without password$/) do
	fill_in 'Email', :with => "xyz@seas.upenn.edu"
	click_button "Sign up"
end

Then (/^I can't create an user without password$/) do
	assert page.has_content?("Password can't be empty")
end