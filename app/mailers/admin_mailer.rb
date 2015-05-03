class AdminMailer < ApplicationMailer
  def email(recipients, title, message)
    @message = message
    mail(subject: title, to: recipients)
  end
end
