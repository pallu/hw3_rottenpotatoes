# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    #debugger
    Movie.create(title:movie["title"],rating:movie["rating"],release_date:movie["release_date"])
    #end
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #debugger
  pose1 = page.body.index(e1)
  pose2 = page.body.index(e2)
  (pose1.should_not be_nil) && (pose2.should_not be_nil) && (pose1.should be < pose2)
  #debugger
  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
  ratings = rating_list.split(',')
  #debugger
  if (uncheck.nil?)
  	$filteredMovies = Movie.find_all_by_rating(ratings)
  	#debugger
  end
  ratings.each do |rating|
  	if (uncheck.nil?)
  		#check(ratings_'#rating')
  		check("ratings_#{rating}")
  	else
  		#uncheck(ratings_'#rating')
  		uncheck("ratings_#{rating}")
  	end
  end
end

When /^I press Refresh$/ do
  #debugger
  click_button("ratings_submit")
end

Then /^I should see movies with 'PG' or 'R' ratings$/ do
  #debugger
  actual_number = page.all('#movies tr').size - 1
  debugger
  actual_number.should == $filteredMovies.count
end


Then /^I should see all of the movies$/ do
  #pending # express the regexp above with the code you wish you had
  actual_number = page.all('#movies tr').size - 1
  debugger
  actual_number.should == $filteredMovies.count
end


#Then /^show me the page$/ do
#  save_and_open_page
#end

