require "rails_helper"
require 'spec_helper'

RSpec.feature 'user_management.user_login', :type => :feature do


  scenario "User visits login page" do
    visit "/"

	find_field('E-mail').visible?
	find_field('Password').visible?
	find_button("Log in")
  end

   scenario 'user logs in with correct creds' do
	visit '/'
	fill_in('E-mail', with: 'test@user.com')
	fill_in('Password', with: '123456qwe')
	click_button "Log in"
   end

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
