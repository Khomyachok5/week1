class SiteController < ApplicationController
  def index
    session[:UserLoggedIn] = false
  end
end
