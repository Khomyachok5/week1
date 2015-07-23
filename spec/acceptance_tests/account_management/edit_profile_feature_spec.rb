RSpec.feature 'user_management.edit_profile', :type => :feature do
  background do
    register_account('test1@user.com', '123456qwe', 'MySuperSD')
    register_account('test2@user.com', '123456asd', 'MySuperSD2')
    visit_url "mysupersd.lvh.me:3000/"
  end

  context "User is logged in and on admin page" do
    before(:each) do
      log_in_with('test1@user.com','123456qwe')
      click_link('Edit profile')
    end

    scenario 'user visits edit profile page' do
      expect_page_url_to_be 'mysupersd.lvh.me:3000/editprofile' 
      find_field('Password').visible?
      find_field('Password confirmation').visible?
      find_button("Change password", disabled: true)
      expect_no_errors
    end

    scenario 'logged out user cannot visit edit profile page' do
      click_link('Log out')
      expect_page_url_to_be 'mysupersd.lvh.me:3000/'
      visit_url 'mysupersd.lvh.me:3000/editprofile'
      expect_page_url_to_be 'mysupersd.lvh.me:3000/'
      expect_error('Log in to manage your store')
    end

    scenario 'user sets new password' do
      fill_in('Password', with: '123456qwe_new')
      fill_in('Password confirmation', with: '123456qwe_new')
      click_button("Change password")
      expect_page_url_to_be 'mysupersd.lvh.me:3000/editprofile'
      expect(page).to have_content('Password successfully changed')
      expect_no_errors
    end

    scenario 'user enters blank password' do
      fill_in('Password', with: '')
      fill_in('Password confirmation', with: '123456qwe_new')
      find_button("Change password", disabled: true)
    end

    scenario 'user re-enters blank password' do
      fill_in('Password', with: '123456qwe_new')
      fill_in('Password confirmation', with: '')
      find_button("Change password", disabled: true)
    end

    scenario 'user re-enters incorrect password' do
      fill_in('Password', with: '123456qwe_new')
      fill_in('Password confirmation', with: '123456qwe_new123')
      find_button("Change password", disabled: true)
      expect_error('passwords do not match')
    end

    scenario 'user logs in with new password' do
      fill_in('Password', with: '123456qwe_new')
      fill_in('Password confirmation', with: '123456qwe_new')
      click_button("Change password")
      click_link('Log out')
      log_in_with('test1@user.com','123456qwe_new')
      expect_page_url_to_be 'mysupersd.lvh.me:3000/admin'
      expect(page).to have_content('Hello test1@user.com')
      expect(page).to have_content('Subdomain MySuperSD')
    end

    scenario 'user tries to logs in with old password' do
      fill_in('Password', with: '123456qwe_new')
      fill_in('Password confirmation', with: '123456qwe_new')
      click_button("Change password")
      click_link('Log out')
      log_in_with('test1@user.com','123456qwe')
      expect_page_url_to_be 'mysupersd.lvh.me:3000/'
      expect_error('Incorrect email/password')
    end
  end
end

