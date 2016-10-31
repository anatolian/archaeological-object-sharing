Given (/^I have set up the user database$/) do
	User.create(
		username: "Tom",
		email: "Tom@seas.upenn.edu",
		password: "12345678",
		password_confirmation: "12345678")
end

Given (/^I'm in the user sign in page$/) do
	visit(new_user_session_path)
end

When (/^I fill the username and password and sign in$/) do
	fill_in 'Login', :with => "Tom"
	fill_in 'Password', :with => "12345678"
	click_button "Sign in"
end

Then (/^I should be able to sign in successfully ans routes to my user homepage$/) do
	assert page.has_content?("Signed in successfully.")
	assert page.has_content?("Tom 's page")
end

