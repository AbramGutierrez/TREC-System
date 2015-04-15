class ConfirmationMailer < ApplicationMailer
  default from: ConfirmationMailer.default_from()
  
  def self.default_from()
    'TREC@sec.tamu.edu'
  end
  
  def welcome_email(user)
    @user = user
    @url = 'http://trec.herokuapp.com/confirmation/#{user.user_id}'
    mail(to: @user.email, subject: 'Welcome to TREC')
  end
end
