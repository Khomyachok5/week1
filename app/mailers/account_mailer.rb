class AccountMailer < ApplicationMailer

  def reset_password(email)
    @account = Account.find_by email: email
    mail(to: email, subject: 'Password re-set instructions for Week1')
  end

end