class AccountsController < ApplicationController
  before_action :authorize!, only: [:edit, :show]

  def new
  end

  def edit
  end

  def create
    account = Account.new params.require(:account).permit(:subdomain, :email, :password)
    account.user_logged_in = true
    account.subdomain.downcase!
    if account.save
      redirect_to admin_url subdomain: account.subdomain
    else
      flash.alert = account.errors.full_messages.join('<br />')
      redirect_to accounts_new_path
    end
  end

  def show
  end

  def login
    session[:email] = params[:login][:email]
    sign_in if current_account
    if current_account && current_account.password == params[:login][:password] && current_account.subdomain.downcase == request.subdomain.downcase
      flash[:notice] = "Hello #{current_account.email} Subdomain #{current_account.subdomain.downcase}"
      redirect_to admin_path
    else
      flash[:alert] = 'Incorrect email/password'
      redirect_to root_path
    end
  end

  def forgotpassword
    email = params[:login][:email]
    session[:email] = email
    if Account.find_by email: email
      AccountMailer.reset_password(email).deliver_now
    end
    flash[:notice] = 'instructions were sent'
    flash[:alert] = "Couldn't find account for #{email}"
    redirect_to forgotpassword_path
  end

  def update_pass
    current_account.update(password: params[:account][:password])
    flash[:notice] = 'Password successfully changed'
    redirect_to root_path
  end

  def update
    current_account.update(password: params[:account][:password])
    redirect_to edit_profile_path
  end

  private

  def sign_in
    current_account.update user_logged_in: true
  end

  def signed_in?
    current_account.try :user_logged_in
  end

  def authorize!
    return if signed_in?
    flash[:alert] = 'Log in to manage your store'
    redirect_to root_path
  end
end