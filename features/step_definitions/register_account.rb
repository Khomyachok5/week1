When(/^user clicks "(.*?)" link$/) do |lnk|
  click_link(lnk)
end

Then(/^user should be redirected to (.*?)$/) do |target_page|
  expect(current_path).to eq(target_page)
end

Then(/^all fields are visible$/) do
  find_field('E-mail').visible?
  find_field('Password').visible?
  find_field('Password confirmation').visible?
  find_field('Sub-domain name').visible?
end

Given(/^user visits (.*?)$/) do |target_page|
  visit target_page
end

When(/^user properly fills the form$/) do
  fill_in('E-mail', with: 'test@user.com')
  fill_in('Password', with: '123456qwe')
  fill_in('Password confirmation', with: '123456qwe')
  fill_in('Sub-domain name', with: 'test_subdomain')
end

When(/^presses "(.*?)" button$/) do |btn_label|
  click_button btn_label
end

When(/^user leaves email field blank$/) do
  fill_in('E-mail', with: '')
end

Then(/^user should see "(.*?)" button is disabled$/) do |btn_label|
  find_button(btn_label, disabled: true)
end

When(/^enters incorrect email$/) do
  fill_in('E-mail', with: 'test#user,com')
end

Then(/^user should see "(.*?)" message$/) do |message_text|
  expect(page).to have_content(message_text)
end

When(/^enters existing email$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^user leaves subdomain field blank$/) do
  fill_in('Sub-domain name', with: '')
end

When(/^enters incorrect subdomain$/) do
  fill_in('Sub-domain name', with: 'hello world !!!')
end

When(/^enters existing subdomain$/) do
  #fill_in('Sub-domain name', with: 'test_subdomain')
  pending # express the regexp above with the code you wish you had
end

When(/^user leaves password field blank$/) do
  fill_in('Password', with: '')
end

When(/^user leaves re\-enter password field blank$/) do
  fill_in('Password confirmation', with: '')
end

When(/^user fills re\-enter password field with incorrect password$/) do
  fill_in('Password', with: '123456qwe')
  fill_in('Password confirmation', with: '123456qwe!')
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
