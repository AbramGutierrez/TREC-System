class Administrator < ActiveRecord::Base
	has_one :account, :as => :user, dependent: :destroy
	
	validates :account, presence: true
	
	accepts_nested_attributes_for :account
	
	after_initialize do
	  @recipient_participant = "participant"
    @recipient_captain = "captain"
    @method_email = "email"
    @method_text_message = "text message"
	end
	
	cattr_reader :recipient_participant
	cattr_reader :recipient_captain
	cattr_reader :method_email
	cattr_reader :method_text_message
	
	def self.get_recipients(type)
	  recipients = Array.new
	  active_teams = Team.get_active_teams()
	  if type == @recipient_participant
	    active_teams.each do |team|
	      recipients.push team.participants
	    end
	  elsif type == @recipient_captain
	    active_teams.each do |team|
        recipients.push team.get_captain()
      end
	  end
	  recipients.flatten
	end
	
	def self.get_message_addresses(users, method_type)
	  addresses = Array.new
	  if method_type == @method_email
	    accounts = Account.get_accounts(users)
	    accounts.each do |account|
	      addresses.push account.email
	    end
	  elsif method_type == @method_text_message
	     users.each do |user|
	       number = user.phone
	       domain = user.domain()
	       address = number + "@" + domain
	       addresses.push(address)
	     end
	  end
	  addresses
	end
	
	def self.email(recipients_type, method_type, message)
	  recipients = get_recipients(recipients_type)
	  addresses = get_message_addresses(recipients, method_type)
	  AdminMailer.email(addresses, "title", message)
	end
end
