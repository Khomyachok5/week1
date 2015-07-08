RSpec.feature 'user_management.user_login', :type => :feature do
  background do
    visit "/"
    Account.create(email: 'test1@user.com', password: '123456qwe', subdomain: 'MySuperSD')
    Account.create(email: 'test2@user.com', password: '123456asd', subdomain: 'MySuperSD1')
  end

  context "User is logged in and on admin page" do
    before(:each) do
      log_in_with('test1@user.com','123456qwe')
      click_link('Edit profile')
    end

    scenario 'user visits edit profile page' do
      expect_page_url_to_be '/editprofile' 
      
    end

    scenario 'logged out user cannot visit edit profile page' do
      click_link('Log out')
      expect_page_url_to_be '/'
      visit '/editprofile'
      expect_page_url_to_be '/'
      expect_error('Log in to manage your store')
    end

    scenario 'user changes password' do
            
    end

  end

  scenario 'dummy_scenario' do
    visit '/'
  end

end


  

