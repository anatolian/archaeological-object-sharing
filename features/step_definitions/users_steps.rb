Given (/^I am in the my own user page$/) do
	user = User.new(
		:firstname => "f",
		:lastname => "l",
		:email => "example@example.com",
		:password => "123465",
		:password_confirmation => "123465")
	user.skip_confirmation!
	user.save
	visit(user_session_path)
	fill_in 'Email', :with => "example@example.com"
	fill_in 'Password', :with => "123465"
	click_button "Log in"
end

Given (/I am on the user page/) do
	click_link "Users"  
end

When (/I want to see the created user/) do
	click_link "f l"
end

Then (/^I should be able to see the user information$/) do
	assert page.has_content?("Created At")
end

When (/I leave from my profile page/) do
	click_link "f l"
	click_link 'Back'
end

Then (/^I should be able to see the users listing page$/) do
	assert page.has_content?("Users")
end