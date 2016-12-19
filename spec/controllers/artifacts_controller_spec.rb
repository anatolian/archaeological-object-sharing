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

	# The following three tests are new tests added in this iteration for normal credit.
	# added a test to test the sorting method of Artifact controller, which can sort artifacts
	# by name or descriptions
  	it "can sort artifacts by name or description" do
		
		# create 1st artifact
 	 	click_link "New Artifact"
		fill_in 'Name', :with => "bncient artifact for testing"
		fill_in 'Description', :with => "derb..."
		fill_in 'Longitude', :with => "9.9"
		fill_in 'Latitude', :with => "8.8"
		fill_in 'Filepath', :with => "folder/file"
		click_button "Create Artifact"
  		
  		# create second artifact
  		visit(artifacts_path)
 	 	click_link "New Artifact"
		fill_in 'Name', :with => "ancient artifact"
		fill_in 'Description', :with => "Is this really an artifact?"
		fill_in 'Longitude', :with => "11.11"
		fill_in 'Latitude', :with => "22.22"
		fill_in 'Filepath', :with => "folder/file"
		click_button "Create Artifact"
		visit "/artifacts/sort/name"
		# the order of name listed in index page is now changed by starting with ancient artifact
		assert_match(/.*ancient artifact.*bncient artifact for testing.*/, page.all('tbody tr td').collect(&:text).join(', '))
 	end

 	# A new test to test the method for redirecting to the page containing 
 	# ist of users that an artifact belongs to
 	it "can show which user the artifact belong to" do
 	 	click_link "New Artifact"
		fill_in 'Name', :with => "ancient artifact"
		fill_in 'Description', :with => "Is this really an artifact?"
		fill_in 'Longitude', :with => "11.11"
		fill_in 'Latitude', :with => "22.22"
		fill_in 'Filepath', :with => "folder/file"
		click_button "Create Artifact"
		click_link "Artifact's Users"
		assert page.has_content?("Artifact's Users")
 	end

 	# A new test to test the functionality for redirecting to the page containing 
 	# list of groups that an artifact belongs to
  	it "can show what groups the artifact belong to" do
 	 	click_link "New Artifact"
		fill_in 'Name', :with => "ancient artifact"
		fill_in 'Description', :with => "Is this really an artifact?"
		fill_in 'Longitude', :with => "11.11"
		fill_in 'Latitude', :with => "22.22"
		fill_in 'Filepath', :with => "folder/file"
		click_button "Create Artifact"
		click_link "Artifact's Groups"
		assert page.has_content?("Artifact's Groups")
 	end


 	# The following are functionalities that have been tested before when we used cucumber
 	# in oder to get the whole coverage report, we reimplemented them here
	it "can shows list of Artifacts" do
		assert page.has_content?("Artifacts")
	end

 	 it "can make a new artifact" do
 	 	click_link "New Artifact"
 	 	assert page.has_content?("New Artifact")
 	 end


 	 it "can create a artifact" do
 	 	click_link "New Artifact"
		fill_in 'Name', :with => "ancient artifact"
		fill_in 'Description', :with => "Is this really an artifact?"
		fill_in 'Longitude', :with => "11.11"
		fill_in 'Latitude', :with => "22.22"
		fill_in 'Filepath', :with => "folder/file"
		click_button "Create Artifact"
 	 	assert page.has_content?("Artifact was successfully created.")
 	 end

 	 it "can not create artifact without name" do
  	 	click_link "New Artifact"
		click_button "Create Artifact"
		assert page.has_content?("Name can't be blank")	 	
 	 end


 	 it "can edit artifact" do
 	 	click_link "New Artifact"
		fill_in 'Name', :with => "ancient artifact"
		fill_in 'Description', :with => "Is this really an artifact?"
		fill_in 'Longitude', :with => "11.11"
		fill_in 'Latitude', :with => "22.22"
		fill_in 'Filepath', :with => "folder/file"
		click_button "Create Artifact"
		click_link "Edit"
		assert page.has_content?("Editing Artifact")	 	
 	 end

 	 it "can update artifact after editing" do
 	 	click_link "New Artifact"
		fill_in 'Name', :with => "ancient artifact"
		fill_in 'Description', :with => "Is this really an artifact?"
		fill_in 'Longitude', :with => "11.11"
		fill_in 'Latitude', :with => "22.22"
		fill_in 'Filepath', :with => "folder/file"
		click_button "Create Artifact"
		click_link "Edit"
		fill_in 'Description', :with => "updateing this artifact"
		click_button "Update Artifact"
		assert page.has_content?("Artifact was successfully updated.")	 	
 	 end

 	 # it fails to update and stay in the editing page
 	 it "can not update artifact to be without name" do
 	 	click_link "New Artifact"
		fill_in 'Name', :with => "ancient artifact"
		fill_in 'Description', :with => "Is this really an artifact?"
		fill_in 'Longitude', :with => "11.11"
		fill_in 'Latitude', :with => "22.22"
		fill_in 'Filepath', :with => "folder/file"
		click_button "Create Artifact"
		click_link "Edit"
		fill_in 'Name', :with => ""
		click_button "Update Artifact"
		# assert page.has_content?("Editing Artifact")
		assert page.has_content?("Name can't be blank")	
 	 end


  	it "can delete an artifact" do
 	 	click_link "New Artifact"
		fill_in 'Name', :with => "ancient artifact"
		fill_in 'Description', :with => "Is this really an artifact?"
		fill_in 'Longitude', :with => "11.11"
		fill_in 'Latitude', :with => "22.22"
		fill_in 'Filepath', :with => "folder/file"
		click_button "Create Artifact"
		visit(artifacts_path)
		# assert page.has_content?("Artifacts")
		click_link "Destroy"
		assert page.has_content?("Artifact was successfully destroyed")		
 	end

  	it "can show all tags for a specific artifact" do
  		artifact = Artifact.new(name: "ancient artifact", description: "derb...")
  		artifact.save
 	 	click_link "New Artifact"
		fill_in 'Name', :with => artifact.name
		fill_in 'Description', :with => artifact.description
		visit "/artifacts/1/tags"
		assert page.has_content?("Tags")	
	end

end