class ConfirmationMailer < ApplicationMailer
  def self.default_from()
    'trec.system.test@gmail.com'
  end
  
  default from: ConfirmationMailer.default_from()
  
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to TREC')
  end
end
