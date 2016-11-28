Given (/^I am loged in and I am in the user page already$/) do
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

Given (/I am on the artifacts page/) do 
	click_link "Artifacts"
end

When (/I want to create a artifact/) do
	click_link "New Artifact"
	fill_in 'Name', :with => "ancient artifact"
	fill_in 'Description', :with => "Is this really an artifact?"
	fill_in 'Longitude', :with => "11.11"
	fill_in 'Latitude', :with => "22.22"
	fill_in 'Filepath', :with => "folder/file"
	click_button "Create Artifact"
end

Then (/^I should be able to see the artifact information$/) do
	assert page.has_content?("Artifact was successfully created")
end

When (/I decide not to create artifacts/) do
	click_link "New Artifact" 
	click_link "Back"
end

Then (/I will go back to artifacts listing page/) do
	assert page.has_content?("Artifacts") 
end