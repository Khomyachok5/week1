class SiteController < ApplicationController
  def index
    current_account.update user_logged_in: false if current_account
  end
end
