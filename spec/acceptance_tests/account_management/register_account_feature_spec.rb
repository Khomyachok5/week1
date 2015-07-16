RSpec.feature 'user_management.register_account', :type => :feature do
  background do
    visit_url "localhost:8080"
  end

  scenario "User registers account" do
    register_account('test@user.com','123456qwe','MySuperSD')
    expect_page_url_to_be 'mysupersd.localhost:8080/admin'
    expect_no_errors
  end

end


  

