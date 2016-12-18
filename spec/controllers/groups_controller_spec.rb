require "rails_helper"
# require "spec_helper"

RSpec.describe UsersController, :type => :controller do 

	before(:each) do
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

	it "can show all groups" do
		click_link "Groups"
		assert page.has_content?("Groups")
	end

	it "can create new groups" do
		click_link "Groups"
		click_link "New Group"
		assert page.has_content?("New Group")
	end

	it "can update and save a group" do
		click_link "Groups"
		click_link "New Group"
		fill_in 'Name', :with => "some group"
		click_button "Create Group"
		assert page.has_content?("Group was successfully created.")		
	end

	it "can not create group without name" do
		click_link "Groups"
		click_link "New Group"
		click_button "Create Group"
		assert page.has_content?("Name can't be blank")
	end

	it "can edit a group" do
		click_link "Groups"
		click_link "New Group"
		fill_in 'Name', :with => "some group"
		click_button "Create Group"
		click_link "Edit"
		assert page.has_content?("Editing Group")	
	end

	it "can update a group after editing" do
		click_link "Groups"
		click_link "New Group"
		fill_in 'Name', :with => "some group"
		click_button "Create Group"
		click_link "Edit"
		fill_in 'Name', :with => "new awesome name"
		click_button "Update Group"
		assert page.has_content?("Group was successfully updated.")
	end

	it "can not update a group to be without name" do
		click_link "Groups"
		click_link "New Group"
		fill_in 'Name', :with => "some group"
		click_button "Create Group"
		click_link "Edit"
		fill_in 'Name', :with => ""
		click_button "Update Group"
		assert page.has_content?("Name can't be blank")
	end

	it "can shows all artifacts that the group has" do
		click_link "Groups"
		click_link "New Group"
		fill_in 'Name', :with => "some group"
		click_button "Create Group"
		click_link "Group's Artifacts"
		assert page.has_content?("Group's Artifacts")
	end

	it "can shows all users that the group has" do
		click_link "Groups"
		click_link "New Group"
		fill_in 'Name', :with => "some group"
		click_button "Create Group"
		visit "1/users"
		assert page.has_content?("Group's Users")
	end

	it "can delete a group" do
		click_link "Groups"
		click_link "New Group"
		fill_in 'Name', :with => "some group"
		click_button "Create Group"
		visit(groups_path)
		click_link "Destroy"
		assert page.has_content?("Group was successfully destroyed")
	end

  	it "can sort the all groups by their names" do
		click_link "Groups"
		click_link "New Group"
		fill_in 'Name', :with => "some group"
		click_button "Create Group"

		visit "/groups/sort/name"
		assert page.has_content?("Groups")		
 	end

end
