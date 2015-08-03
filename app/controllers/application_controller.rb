class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def current_account
    email = session[:email]
    if email
      @current_account ||= Account.find_by(email: email)
    else
      subdomain = request.host.split('.').first
      @current_account ||= Account.find_by(subdomain: subdomain)
    end
  end
end
