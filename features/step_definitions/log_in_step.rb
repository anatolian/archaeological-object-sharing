Given (/^I have a user account$/) do
	User.create(
		email: "xyz@seas.upenn.edu",
		password: "123456",
		password_confirmation: "123456")
end

Given (/^I'm in the user login page$/) do
	visit(user_login_path)
end

When (/^I do not have a user account$/) do
	click_button "CreateAccount"
end

Then (/^I will go to signup page$/) do
	assert page.has_button?("CreateAccount")
end

When (/^I fill the username and password and log in$/) do
	fill_in 'Login', :with => "xyz@seas.upenn.edu"
	fill_in 'Password', :with => "123456"
	click_button "Login"
end

Then (/^I should be able to log in successfully and go to my user homepage$/) do
	assert page.has_content?("Your ArtiFacts:")
end