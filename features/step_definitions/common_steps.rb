Given(/^visitor opens start page$/) do
  visit '/'
end

Then(/^visitor should see link to new account registration page$/) do
  find_link('RegisterLink').visible?
end
