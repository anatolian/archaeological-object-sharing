Given (/^I'm on the user sign up page$/) do
	visit(new_user_registration_path)
end

When (/^I add a new user$/) do
	fill_in 'Username', :with => "Tom"
	fill_in 'Email', :with => "tom@seas.upenn.edu"
	fill_in 'Password', :with => "12345678"
	fill_in 'Password confirmation', :with => "12345678"
	click_button "Sign up"
end

Then (/^I should be able to see the userpage with user signing in$/) do
	assert page.has_content?("Welcome! You have signed up successfully.")
end

When (/^I add a new user without username$/) do
	fill_in 'Email', :with => "tom@seas.upenn.edu"
	fill_in 'Password', :with => "12345678"
	fill_in 'Password confirmation', :with => "12345678"
	click_button "Sign up"
end

Then (/^I can't create an user without username$/) do
	assert page.has_content?("Username can't be blank")
end

When (/^I add a new user without password$/) do
	fill_in 'Username', :with => "Tom"
	fill_in 'Email', :with => "tom@seas.upenn.edu"
	click_button "Sign up"
end

Then (/^I can't create an user without password$/) do
	assert page.has_content?("Password can't be blank")
end