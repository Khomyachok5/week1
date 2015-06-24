class AccountsController < ApplicationController
  def new
  end

  def create
    if Account.find_by subdomain: params[:account][:subdomain]
      redirect_to '/accounts/new'
    else
      account = Account.new
      account.subdomain = params[:account][:subdomain]
      account.save
      redirect_to '/admin'
    end
  end

  def show
    render text: 'invalid email invalid subdomain', layout: true
  end
end