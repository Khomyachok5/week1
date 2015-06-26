class AccountsController < ApplicationController
  def new
  end

  def create
    account = Account.new
    account.subdomain = params[:account][:subdomain]

    if account.save
      redirect_to '/admin'
    else
      flash.alert = account.errors.full_messages.join('<br />')
      redirect_to '/accounts/new'
    end
  end

  def show
    render text: 'invalid email', layout: true
  end
end