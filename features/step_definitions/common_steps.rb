Given(/^visitor opens start page$/) do
  visit "http://localhost:8080"
end

Then(/^visitor should see link to new account registration page$/) do
  find_link('Create new account').visible?
end

Then(/^visitor should see login form$/) do
  find_field('E-mail').visible?
  find_field('Password').visible?
  find_button("Log in")
end
