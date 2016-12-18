# require "rails_helper"
# # require "spec_helper"

# RSpec.describe UsersController, :type => :controller do

# 	before(:each) do
# 		user = User.new(
# 			:firstname => "f",
# 			:lastname => "l",
# 			:email => "example@example.com",
# 			:password => "123465",
# 			:password_confirmation => "123465")
# 		user.skip_confirmation!
# 		user.save
# 		visit(user_session_path)
# 		fill_in 'Email', :with => "example@example.com"
# 		fill_in 'Password', :with => "123465"
# 		click_button "Log in"
# 	end

# 	it "log in and shows log in information" do
# 	# user = User.new(
# 	# 	:firstname => "f",
# 	# 	:lastname => "l",
# 	# 	:email => "example@example.com",
# 	# 	:password => "123465",
# 	# 	:password_confirmation => "123465")
# 	# user.skip_confirmation!
# 	# user.save
# 	# visit(user_session_path)
# 	# fill_in 'Email', :with => "example@example.com"
# 	# fill_in 'Password', :with => "123465"
# 	# click_button "Log in"
# 		assert page.has_content?("Welcome to Artifact Tracker!")
# 		# visit(users_path)

#  	 end


#  	 it "shows list of users" do
#  	 	puts "before"
#  	 	puts page.html
#  	 	# visit(groups_path)
#  	 	click_link "Groups"
#  	 	# page.find_link("Users").click
#  	 	puts "after"
#  	 	puts page.html
#  	 	assert page.has_content?("Groups")
 	 	
#  	 	# user = @users.first
#  	 	# # expect(response).to redirect_to users_path
#  	 	# # assert current_path == "/users/index" 
#  	 	# # assert page.has_content?("Users")
#  	 	# expect(user.firstname).to eq "f"
#  	 end


#  	 it "shows artifact" do
#  	 	click_link "New Artifact"
#  	 	assert page.has_content?("New Artifact")
#  	 end


#  	 # it "test users#sort" do
#  	 # 	visit()
#  	 # end	
# end