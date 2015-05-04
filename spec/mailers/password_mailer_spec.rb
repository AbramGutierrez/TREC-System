require "rails_helper"

RSpec.describe PasswordMailer, type: :mailer do
  describe "sends a confirmation email" do
    let(:participant) { Participant.new() }
    let(:account) { Account.create!(first_name: "first", last_name: "last",
                email: "valid_email@test.com", user: participant)
    }
    let(:mail) { PasswordMailer.welcome_email(account) }
    
    it "containing the user's first password" do
      expect(mail.body.encoded).to match(account.password)
    end
    
    it "containing a 6-digit password" do
      expect(account.password.length()).to be_within(2).of(6)
    end
    
    it "and renders the subject" do
      expect(mail.subject).to match('Welcome to TREC')
    end
    
    it "to the correct person" do
      expect(mail.to).to match([account.email])
    end
    
    it "from TREC" do
      expect(mail.from).to match([PasswordMailer.default_from()])
    end
    
    it "containing the user's name" do
      expect(mail.body.encoded).to match(account.name)
    end
    
    it "containing a link to the login page" do
      expect(mail.body.encoded).to match('http://trec.herokuapp.com/login')
    end
  end
  
  describe "sends a confirmation email" do
    let(:participant) { Participant.new() }
    
    it "and adds to the total mail sent" do
      expect { Account.create(first_name: "first", last_name: "last", email: "valid_email@test.com", user: participant) }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
  
  describe "sends a reset password email" do
    let(:participant) { Participant.new() }
    let(:account) { Account.create(first_name: "first", last_name: "last",
                email: "valid_email@test.com", user: participant,
                password: "new_password")
    }
    let(:mail) { PasswordMailer.reset_email(account) }
    
    it "containing the user's new password" do
      expect(mail.body.encoded).to match(account.password)
    end
    
    it "and renders the subject" do
      expect(mail.subject).to match('TREC Password Reset')
    end
    
    it "to the correct person" do
      expect(mail.to).to match([account.email])
    end
    
    it "from TREC" do
      expect(mail.from).to match([PasswordMailer.default_from()])
    end
    
    it "containing a link to the login page" do
      expect(mail.body.encoded).to match('http://trec.herokuapp.com/login')
    end
    
    it "after changing the user's password" do
      account.randomize_password()
      new_mail = PasswordMailer.reset_email(account)
      expect(new_mail.body.encoded).to match(account.password)
    end
  end
end