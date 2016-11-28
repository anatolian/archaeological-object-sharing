Given (/^I am already in the user page already$/) do
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

Given (/I am on the groups page/) do
	click_link "Groups" 
end

When (/I want to create a group/) do
	click_link 'New Group'
	@group_name = "best group name ever"
	fill_in 'Name', :with => @group_name
	click_button "Create Group"
end

Then (/^I should be able to see the group name$/) do
	assert page.has_content?(@group_name)
end

When (/I decide not to create a new group/) do
	click_link 'New Group' 
	click_link "Back"
end

Then (/I will go back to groups creating page/) do
	assert page.has_content?("Groups") 
end