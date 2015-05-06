require "rails_helper"

RSpec.describe AdminMailer, type: :mailer do
  describe "sends an email" do
    let(:account_list) { [Account.create!(first_name: "first", last_name: "last",
                email: "valid_email1@test.com", user: Participant.new()),
                Account.create!(first_name: "first", last_name: "last",
                email: "valid_email2@test.com", user: Participant.new()),
                Account.create!(first_name: "first", last_name: "last",
                email: "valid_email3@test.com", user: Participant.new())]
    }
    let(:to_list) {
      list = Array.new
      account_list.each do |account|
        list.insert(account.email)
      end
      list
    }
    let(:subject) { "This is a subject" }
    let(:body) { "This is the message body. Please enjoy this message." }
    let(:mail) { AdminMailer.email(to_list, subject, body) }
    
    it "and renders the subject" do
      expect(mail.subject).to eql(subject)
    end
    
    it "to the correct person" do
      expect(mail.to).to match(to_list)
    end
    
    it "from TREC" do
      expect(mail.from).to match_array([AdminMailer.default_from()])
    end
    
    it "containing the user's name" do
      expect(mail.body.encoded).to include(body)
    end
  end
end
