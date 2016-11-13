Given (/I am on the groups page/) do 
	visit groups_path
	click_link 'New Group'
end

When (/I want to create a group/) do
	@group_name = "best group name ever"
	fill_in 'Name', :with => @group_name
	click_button "Create Group"
end

Then (/^I should be able to see the group name$/) do
	assert page.has_content?(@group_name)
end

When (/I decide not to create a new group/) do 
	click_link "Back"
end

Then (/I will go back to groups creating page/) do
	assert page.has_content?("Listing Groups") 
end