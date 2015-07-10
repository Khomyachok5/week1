class AccountsController < ApplicationController
  def new
  end

  def edit
    unless session[:UserLoggedIn]
      flash[:alert] = 'Log in to manage your store'
      redirect_to root_path
    end
  end

  def create
    session[:UserLoggedIn] = true
    account = Account.new params.require(:account).permit(:subdomain, :email, :password)
    if account.save
      redirect_to '/admin'
    else
      flash.alert = account.errors.full_messages.join('<br />')
      redirect_to '/accounts/new'
    end
  end

  def show
    unless session[:UserLoggedIn]
      flash[:alert] = 'Log in to manage your store'
      redirect_to root_path
    end
  end

  def login
    session[:UserLoggedIn] = true
    session[:email] = params[:login][:email]
    current_account = Account.find_by email: params[:login][:email]
    if current_account && current_account.password == params[:login][:password]
      flash[:notice] = "Hello #{current_account.email} Subdomain #{current_account.subdomain}"
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
    Account.find_by(email: session[:email]).update(password: params[:account][:password])
    flash[:notice] = 'Password successfully changed'
    redirect_to root_path
  end

  def update
    Account.find_by(email: session[:email]).update(password: params[:account][:password])
    redirect_to edit_profile_path
  end
end