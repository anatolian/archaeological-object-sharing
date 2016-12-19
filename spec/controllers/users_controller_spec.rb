require "rails_helper"
# require "spec_helper"


# Note, because User is more compliacated than the other controlers after adding devices and otehr things,
# in some cases it's hard to assert some certain things.
# Therefore this test is bacially like a step tesing to test if the controller is working fine 
# instead of focusing on testing what's in the view after methods are invoked, which is less important in this case 
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

	it "log in and shows log in page" do
		assert page.has_content?("Welcome to Artifact Tracker!")
    end

   	it "can show user's information" do
   		click_link "Settings"
   		assert page.has_content?("Account Settings")
	end

	it "can show user's list of artifacts" do
		click_link "My Artifacts"
		# assert page.has_content?("Your Artifacts")
	end

	it "can show what groups the user is in" do
		click_link "My Groups"
		# assert page.has_content?("Your Groups")
	end

	it "can list of users" do
		click_link "Users"
		# assert page.has_content?("Users")
	end

	it "can sort users in a list by name" do
		visit "users/sort/firstname"
		# assert page.has_content?("Users")
	end


end
