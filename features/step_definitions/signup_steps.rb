Given (/^I'm on the user sign up page$/) do
	visit(new_user_registration_path)
end

When (/^I add a new user$/) do
	fill_in 'Firstname', :with => "first"
	fill_in 'Lastname', :with => "last"
	fill_in 'Email', :with => "fl@seas.upenn.edu"
	fill_in 'Password', :with => "123456"
	fill_in 'Password confirmation', :with => "123456"
	click_button "Sign up"
end

Then (/^I should be able to see the log in page$/) do
	assert page.has_content?("Log in")
end

When (/^I add a new user without email$/) do
	fill_in 'Firstname', :with => "first"
	fill_in 'Lastname', :with => "last"
	fill_in 'Password', :with => "123456"
	fill_in 'Password confirmation', :with => "123456"
	click_button "Sign up"
end

Then (/^I can't create an user without email$/) do
	assert page.has_content?("Email can't be blank")
end

When (/^I add a new user with short password$/) do
	fill_in 'Firstname', :with => "first"
	fill_in 'Lastname', :with => "last"
	fill_in 'Email', :with => "fl@seas.upenn.edu"
	fill_in 'Password', :with => "123"
	fill_in 'Password confirmation', :with => "123"
	click_button "Sign up"
end

Then (/^I can't create an user with short password$/) do
	assert page.has_content?("Password is too short")
end
