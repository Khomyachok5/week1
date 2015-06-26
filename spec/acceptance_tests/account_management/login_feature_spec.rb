require "rails_helper"
require 'spec_helper'

RSpec.feature 'User logs in', :type => :feature do
  scenario "User creates a new widget" do
    visit "/accounts/new"

    fill_in "E-mail", :with => "qwe@asd.com"
    fill_in "Password", :with => "qweqweqwe"
    fill_in "Password confirmation", :with => "qweqweqwe"
    fill_in "Sub-domain name", :with => "qweqweqwedomain"
    click_button "Create Account"

    expect(current_path).to eq("/admin")
  end
end


# RSpec.feature 'User logs in', :type => :feature do

#   scenario 'user visits login page' do
#   	visit '/'
#   	pending #do some actions
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
