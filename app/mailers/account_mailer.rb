class AccountMailer < ApplicationMailer

  def reset_password(email)
  	mail(to: email, subject: 'Password re-set instructions for Week1')
  end
  
end