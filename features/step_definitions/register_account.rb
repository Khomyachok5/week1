Given(/^user visits start page$/) do
  visit '/'
end

When(/^user clicks "(.*?)" link$/) do |lnk|
  click_link(lnk)
end

Then(/^user should be redirected to "(.*?)" page$/) do |target_page|
  current_path.should == target_page
end

Then(/^registration page contains all fields$/) do
  find_field('email').visible?
  find_field('password').visible?
  find_field('re-type password').visible?
end

Given(/^user visits registration page$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^user properly fills the form$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^presses "(.*?)" button$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^user leaves email field blank$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^user should see "(.*?)" button is disabled$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^enters incorrect email$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^user should see "(.*?)" message$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^enters existing email$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^user leaves subdomain field blank$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^enters incorrect subdomain$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^enters existing subdomain$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^user leaves password field blank$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^user leaves re\-enter password field blank$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^user fills re\-enter password field with incorrect password$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^user creates new account$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^user receives confirmation email$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^follows email confirmation link$/) do
  pending # express the regexp above with the code you wish you had
end
