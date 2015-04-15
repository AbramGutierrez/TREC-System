require "rails_helper"

RSpec.describe ConfirmationMailer, type: :mailer do
  describe "sends a confirmation email" do
    let(:participant) { Participant.new() }
    let(:account) { Account.new(first_name: "first", last_name: "last",
                email: "valid_email@test.com", user: participant)
    }
    
    it "and adds to the total mail sent" do
      expect { ConfirmationMailer.welcome_email(account).deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
