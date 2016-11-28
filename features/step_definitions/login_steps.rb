Given (/^I am a registered user$/) do
	user = User.new(
		:firstname => "f",
		:lastname => "l",
		:email => "example@example.com",
		:password => "123465",
		:password_confirmation => "123465")
	user.skip_confirmation!
	user.save
end

Given (/I go to log in page/) do
	visit(user_session_path)
end

Given (/I am in the user home page/) do
	visit(user_session_path)
	fill_in 'Email', :with => "example@example.com"
	fill_in 'Password', :with => "123465"
	click_button "Log in"
end

When (/^I sign in with username and password$/) do
	fill_in 'Email', :with => "example@example.com"
	fill_in 'Password', :with => "123465"
	click_button "Log in"
end

Then (/^I should be able to sign in successfully$/) do
	assert page.has_content?("Welcome!")
end

When (/I click the sign out link/) do
	click_link "Sign Out"
end

Then (/I should be able to sign out and see sign in page again/) do
	assert page.has_content?("Log in")
end

