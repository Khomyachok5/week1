class AccountsController < ApplicationController
  def new
  end

  def create
    redirect_to '/admin'
  end

  def show
    render text: 'invalid email'
  end
end