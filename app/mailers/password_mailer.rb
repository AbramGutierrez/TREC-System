class PasswordMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to TREC')
  end
  
  def reset_email(user)
    @user = user
    mail(to: @user.email, subject: 'TREC Password Reset')
  end
end
