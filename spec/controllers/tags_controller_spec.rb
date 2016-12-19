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

	# The following two tests are for normal credit.
	# They tested some functionalities we missed in previous iterations.
	it "can delete a tag" do
		click_link "Tags"
		click_link "New Tag"
		fill_in 'Name', :with => "some tag"
		click_button "Create Tag"
		visit(tags_path)
		click_link "Destroy"
		assert page.has_content?("Tag was successfully destroyed")
	end

  	it "can sort the tags by name for a specific artifact" do
 	 	click_link "New Artifact"
		fill_in 'Name', :with => "ancient artifact"
		fill_in 'Description', :with => "Is this really an artifact?"
		fill_in 'Longitude', :with => "11.11"
		fill_in 'Latitude', :with => "22.22"
		fill_in 'Filepath', :with => "folder/file"
		click_button "Create Artifact"
		visit(artifacts_path)
		click_link "ancient artifact"
		click_link "Name"
		assert page.has_content?("Tags")		
 	end


 	# following are tests that have been implemented bofre using cucumber
 	# and added in here to achieve code coverage for extra credit
	it "can show all tags" do
		click_link "Tags"
		assert page.has_content?("Tags")
	end

	it "can create new tags" do
		click_link "Tags"
		click_link "New Tag"
		assert page.has_content?("New Tag")
	end

	it "can create and save new tag" do
		click_link "Tags"
		click_link "New Tag"
		fill_in 'Name', :with => "some tag"
		click_button "Create Tag"
		assert page.has_content?("Tag was successfully created.")
	end

	it "can not create tag without name" do
		click_link "Tags"
		click_link "New Tag"
		click_button "Create Tag"
		assert page.has_content?("Name can't be blank")
	end

	it "can edit a tag" do
		click_link "Tags"
		click_link "New Tag"
		fill_in 'Name', :with => "some tag"
		click_button "Create Tag"
		click_link "Edit"
		assert page.has_content?("Editing Tag")	
	end

	it "can update a tag after editing" do
		click_link "Tags"
		click_link "New Tag"
		fill_in 'Name', :with => "some tag"
		click_button "Create Tag"
		click_link "Edit"
		fill_in 'Description', :with => "add some Description"
		click_button "Update Tag"
		assert page.has_content?("Tag was successfully updated.")
	end

	it "can not update a tag to be without name" do
		click_link "Tags"
		click_link "New Tag"
		fill_in 'Name', :with => "some tag"
		click_button "Create Tag"
		click_link "Edit"
		fill_in 'Name', :with => ""
		click_button "Update Tag"
		assert page.has_content?("Name can't be blank")
	end

	it "can shows all artifacts that have this tag" do
		click_link "Tags"
		click_link "New Tag"
		fill_in 'Name', :with => "some tag"
		click_button "Create Tag"
		click_link "Tag's Artifacts"
		assert page.has_content?("Tag's Artifacts")
	end

end
