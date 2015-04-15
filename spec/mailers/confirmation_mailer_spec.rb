require "rails_helper"

RSpec.describe ConfirmationMailer, type: :mailer do
  it "sends a confirmation email" do
    @participant = Participant.new()
    @account = Account.new(first_name: "first", last_name: "last",
                email: "valid_email@test.com", user: @participant)
    
    email = ConfirmationMailer.welcome_email(@account).deliver_now
  end
end
