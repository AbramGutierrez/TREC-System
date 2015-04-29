class AdminMailer < ApplicationMailer
  def email(accounts, title, message)
    recipients = Proc.new { accounts.pluck(email) }
    @message = message
    mail(subject: title, to: recipients)
  end
end
