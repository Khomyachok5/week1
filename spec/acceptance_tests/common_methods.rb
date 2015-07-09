module Common_methods
  def expect_page_url_to_be(url)
    expect(current_path).to eq(url)
  end

  def expect_error(message)
    expect(page.find('#errors')).to have_content(message)
  end

  def log_in_with(login, pass)
    fill_in('E-mail', with: login)
    fill_in('Password', with: pass)
    click_button "Log in"
  end    
end