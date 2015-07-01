class AccountsController < ApplicationController
  def new
  end

  def create
    account = Account.new params.require(:account).permit(:subdomain, :email, :password)
    if account.save
      redirect_to '/admin'
    else
      flash.alert = account.errors.full_messages.join('<br />')
      redirect_to '/accounts/new'
    end
  end

  def show
    render text: "", layout: true
  end

  def login
    current_account = Account.find_by email: params[:login][:email]
    if current_account && current_account.password == params[:login][:password]
        flash[:notice] = "Hello #{current_account.email} Subdomain #{current_account.subdomain}"
        redirect_to '/admin'
      else
        flash[:alert] = 'Incorrect email/password'
        redirect_to '/'
      end
  end
end