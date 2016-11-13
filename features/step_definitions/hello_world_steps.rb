Given /The Action ([A-z\s]*)/ do |action| 
  @action = action 
end 

When /The Subject is ([A-z]*)/ do |subject| 
  @subject = subject 
end 

Then /The Greeting is (.*)/ do |greeting| 
  puts "#{@action}, #{@subject}" 
end