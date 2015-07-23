module Common_methods
  def expect_page_url_to_be(url)
    expect(current_url).to eq("http://#{url}")
  end

  def visit_url(url)
    visit "http://#{url}"
  end

  def expect_error(message)
    expect(page.find('#errors')).to have_content(message)
  end

  def expect_no_errors
    expect(page.find('#errors').text).to eq ""
  end

  def log_in_with(login, pass)
    fill_in('E-mail', with: login)
    fill_in('Password', with: pass)
    click_button "Log in"
  end

  def register_account(login,pass,subdomain)
    visit_url "lvh.me:3000"
    click_link 'Create new account'
    fill_in('E-mail', with: login)
    fill_in('Password', with: pass)
    fill_in('Password confirmation', with: pass)
    fill_in('Sub-domain name', with: subdomain)
    click_button "Create Account"
  end
end