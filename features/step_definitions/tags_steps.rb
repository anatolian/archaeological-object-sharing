Given (/^I have signed in and I am in the user page already$/) do
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

Given (/I am in the tags page/) do
	click_link "Tags"
end

When (/I want to create a tag/) do
	click_link "New Tag"
	fill_in 'Name', :with => "Levine"
	fill_in 'Description', :with => "this is a description for a new levine"
	click_button "Create Tag"
end

Then (/^I should be able to see the tag information created$/) do
	assert page.has_content?("Tag was successfully created")
end

When (/I decide not to create a new tag/) do
	click_link "New Tag" 
	click_link "Back"
end

Then (/I will go back to tag listing page/) do
	assert page.has_content?("Tags") 
end

When (/I create a tag without description/) do 
	click_link "New Tag"
	fill_in 'Name', :with => "Moore"
	click_button "Create Tag"
end

Then (/^I will still have a successfully created tag$/) do
	assert page.has_content?("Tag was successfully created")
end
 
