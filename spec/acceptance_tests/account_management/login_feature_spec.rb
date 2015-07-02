require "rails_helper"
require 'spec_helper'


RSpec.feature 'user_management.user_login', :type => :feature do
  background do
	visit "/"
	Account.create(email: 'test1@user.com', password: '123456qwe', subdomain: 'MySuperSD')
	Account.create(email: 'test2@user.com', password: '123456asd', subdomain: 'MySuperSD1')
  end

  scenario "User visits login page" do
	find_field('E-mail').visible?
	find_field('Password').visible?
	find_button("Log in")
  end

   scenario 'user logs in with correct creds' do
	fill_in('E-mail', with: 'test1@user.com')
	fill_in('Password', with: '123456qwe')
	click_button "Log in"
	expect_page_url_to_be '/admin'
	expect(page).to have_content('Hello test1@user.com')
	expect(page).to have_content('Subdomain MySuperSD')
   end

   scenario 'user logs in with incorrect login' do
	fill_in('E-mail', with: 'test@user.com')
	fill_in('Password', with: '123456qwe')
	click_button "Log in"
	expect_page_url_to_be '/'
	expect(page.find('#errors')).to have_content('Incorrect email/password')
	find_link('Re-set password').visible?
   end

   scenario 'user opens password reset page' do
	click_link "Re-set password"
	expect_page_url_to_be '/forgotpassword'
	find_field('E-mail').visible?
	find_button("Email instructions", disabled: true)
   end

   scenario 'user enters valid email to re-set password form' do
	click_link "Re-set password"
	expect_page_url_to_be '/forgotpassword'
	find_field('E-mail').visible?
	find_button("Email instructions", disabled: true)
	fill_in('E-mail', with: 'test1@user.com')
	find_button("Email instructions")
   end

   scenario 'user sends password re-set instructions' do
	click_link "Re-set password"
	expect_page_url_to_be '/forgotpassword'
	fill_in('E-mail', with: 'test1@user.com')
	click_button("Email instructions")
	expect(page).to have_content('instructions were sent')
   end

   scenario 'user sends password re-set instructions to non-existing email' do
	click_link "Re-set password"
	expect_page_url_to_be '/forgotpassword'
	fill_in('E-mail', with: 'test1@user.ru')
	click_button("Email instructions")
	expect_page_url_to_be '/forgotpassword'
	find_field('E-mail').visible?
	find_button("Email instructions", disabled: true)
	expect(page).to have_content("Couldn't find account for test1@user.ru'")
   end

   scenario 'user receives password re-set instructions' do
	click_link "Re-set password"
	expect_page_url_to_be '/forgotpassword'
	fill_in('E-mail', with: 'test1@user.com')
	click_button("Email instructions")

    expect(unread_emails_for("test1@user.com").size).to eql 1
    open_last_email_for("test1@user.com")
    expect(current_email).to have_subject(/Password re-set instructions for Week1/)
    expect(current_email).to have_body_text(/Follow the link to re-set your password/)
   end

   scenario 'password re-set instructions contain link to password re-set page' do
	click_link "Re-set password"
	expect_page_url_to_be '/forgotpassword'
	fill_in('E-mail', with: 'test1@user.com')
	click_button("Email instructions")

    open_last_email_for("test1@user.com")
    url = /href=\"([^"]*)\"/.match(current_email.body.to_s)[1]
    expect(url.length).to be > 1
   end


	def expect_page_url_to_be(url)
		expect(current_path).to eq(url)
	end
end

