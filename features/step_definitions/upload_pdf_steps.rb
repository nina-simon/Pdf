require 'action_dispatch/testing/test_process'
Given /^I have not uploaded any pdf yet$/ do
  Upload.delete_all
end

Given /^I've an uploaded pdf named "([^"]*)"$/ do |filename|
  path_with_rails_root = "#{RAILS_ROOT}/#{filename}"
  uploaded_file = if content_type
    ActionController::TestUploadedFile.new(path_with_rails_root, content_type)
  else
    ActionController::TestUploadedFile.new(path_with_rails_root)
  end
  Pdf.create!(uploaded_file)
end
When /^I click on "([^"]*)"$/ do |link|
    click_link(link)
end
Then /^I should have (\d+) pdf uploaded$/ do |count|
  Upload.all.count.should == count.to_i
end

Then /^I should see "([^"]*)" view page$/ do |filename|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(Upload.find_by_filename(filename))
  else
    assert_equal path_to(Upload.find_by_filename(filename)), current_path
  end
end
Then /^the file "([^"]*)" should not be uploaded$/ do |filename|
  Upload.find_by_filename(filename).should == nil
end


