class ApplicationMailer < ActionMailer::Base
  def self.default_from()
    'trec.system.test@gmail.com'
  end
  
  default from: ApplicationMailer.default_from()
  
  layout 'mailer'
end
