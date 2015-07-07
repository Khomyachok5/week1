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

  scenario "User tries to visit admin page without logging in" do
    visit '/admin'
    expect_page_url_to_be '/'
    expect_error('Log in to manage your store')
  end

  scenario 'user logs in with correct creds' do
    log_in_with('test1@user.com','123456qwe')
    expect_page_url_to_be '/admin'
    expect(page).to have_content('Hello test1@user.com')
    expect(page).to have_content('Subdomain MySuperSD')
  end

  scenario 'user logs in with non-existing login' do
    log_in_with('test@user.com', '123456qwe')
    expect_page_url_to_be '/'
    expect_error('Incorrect email/password')
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
    expect(page).to have_content("Couldn't find account for test1@user.ru")
    expect(unread_emails_for("test1@user.ru").size).to eql 0
  end

  context "User has sent re-set instructions email" do
    before(:each) do
      reset_mailer
      click_link "Re-set password"
      expect_page_url_to_be '/forgotpassword'
      fill_in('E-mail', with: 'test1@user.com')
      click_button("Email instructions")
    end

    scenario 'user receives password re-set instructions' do
      expect(unread_emails_for("test1@user.com").size).to eql 1
      open_last_email_for("test1@user.com")
      expect(current_email).to have_subject(/Password re-set instructions for Week1/)
      expect(current_email).to have_body_text(/Follow the link to re-set your password/)
    end

    scenario 'password re-set instructions contain link to password re-set page' do
      open_last_email_for("test1@user.com")
      url = /href=\"([^"]*)\"/.match(current_email.body.to_s)[1]
      expect(url.length).to be > 1
    end

    scenario 'user follows password re-set link from letter' do
      open_last_email_for("test1@user.com")
      url = /href=\"([^"]*)\"/.match(current_email.body.to_s)[1]
      visit url
      find_field('Password').visible?
      find_field('Password confirmation').visible?
      find_button("Set password", disabled: true)
    end

    scenario 'user receives 2 password reset instuctions and follows link from 1st letter' do
      open_last_email_for("test1@user.com")
      #get url from email
      url = /href=\"([^"]*)\"/.match(current_email.body.to_s)[1]
      #then send new email with password reset instuctions
      visit "/"
      click_link "Re-set password"
      expect_page_url_to_be '/forgotpassword'
      fill_in('E-mail', with: 'test1@user.com')
      click_button("Email instructions")
      #try to follow link fromm 1st email
      visit url
    end

    context "User has received re-set instructions email and followed password re-set link from letter" do
      before(:each) do
        open_last_email_for("test1@user.com")
        url = /href=\"([^"]*)\"/.match(current_email.body.to_s)[1]
        visit url
        find_field('Password').visible?
        find_field('Password confirmation').visible?
        find_button("Set password", disabled: true)
      end

      scenario 'user sets new password' do
        fill_in('Password', with: '123456qwe_new')
        fill_in('Password confirmation', with: '123456qwe_new')
        click_button("Set password")
        expect_page_url_to_be '/'
        expect(page).to have_content('Password successfully changed')
      end

      scenario 'user enters blank password' do
        fill_in('Password', with: '')
        fill_in('Password confirmation', with: '123456qwe_new')
        find_button("Set password", disabled: true)
      end

      scenario 'user re-enters blank password' do
        fill_in('Password', with: '123456qwe_new')
        fill_in('Password confirmation', with: '')
        find_button("Set password", disabled: true)
      end

      scenario 'user re-enters incorrect password' do
        fill_in('Password', with: '123456qwe_new')
        fill_in('Password confirmation', with: '123456qwe_new123')
        find_button("Set password", disabled: true)
        expect_error('passwords do not match')
      end

      scenario 'user logs in with new password' do
        fill_in('Password', with: '123456qwe_new')
        fill_in('Password confirmation', with: '123456qwe_new')
        click_button("Set password")
        expect_page_url_to_be '/'
        log_in_with('test1@user.com','123456qwe_new')
        expect_page_url_to_be '/admin'
        expect(page).to have_content('Hello test1@user.com')
        expect(page).to have_content('Subdomain MySuperSD')
      end

      scenario 'user tries to logs in with old password' do
        fill_in('Password', with: '123456qwe_new')
        fill_in('Password confirmation', with: '123456qwe_new')
        click_button("Set password")
        expect_page_url_to_be '/'
        log_in_with('test1@user.com','123456qwe')
        expect_page_url_to_be '/'
        expect_error('Incorrect email/password')
      end
    end
  end

  scenario 'dummy_scenario' do
    visit '/'
  end

end


  

