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
	expect(current_path).to eq('/admin')
	expect(page).to have_content('Hello test@user.com')
	expect(page).to have_content('Subdomain MySuperSD')
   end

   scenario 'user logs in with incorrect login' do
	fill_in('E-mail', with: 'test@user.com')
	fill_in('Password', with: '123456qwe')
	click_button "Log in"
	expect(current_path).to eq('/')
	expect(page.find('#errors')).to have_content('Incorrect email/password')
	find_link('Re-set password').visible?
   end

 #   scenario 'user logs in with correct creds' do
	# fill_in('E-mail', with: 'test@user.com')
	# fill_in('Password', with: '123456qwe')
	# click_button "Log in"
	# expect(current_path).to eq('/admin')
	# expect(page).to have_content('Hello test@user.com')
	# expect(page).to have_content('Subdomain MySuperSD')
 #   end

#   scenario 'user logs in with correct creds' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user logs in with incorrect login' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user logs in with blank login' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user logs in with incorrect' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user logs in with blank password' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user changes password' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user changes password/enters blank password' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user changes password/re-enters blank password' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user changes password/re-enters incorrect password' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user opens password reset page' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user receives password reset instuctions' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user logs in ignoring password reset instructions' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user re-sets password' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user enters blank password on password reset page' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user re-enters incorrect password on password reset page' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user re-enters blank password on password reset page  ' do
#   	visit '/'
#   	pending #do some actions
#   end

#   scenario 'user receives 2 password reset instuctions and follows link from 1st letter' do
#   	visit '/'
#   	pending #do some actions
#   end

#  end
end
