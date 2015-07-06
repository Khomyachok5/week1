module Common_methods
  def expect_page_url_to_be(url)
    expect(current_path).to eq(url)
  end

  def expect_error(message)
    expect(page.find('#errors')).to have_content(message)
  end
end