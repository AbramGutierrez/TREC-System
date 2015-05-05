class Administrator < ActiveRecord::Base
	has_one :account, :as => :user, dependent: :destroy
	
	accepts_nested_attributes_for :account, :update_only => true
	
	validates :account, presence: true
	
	def self.recipient_participant
	  "participant"
	end
	
	def self.recipient_captain
	  "captain"
	end
	
	def self.method_email
	  "email"
	end
	
	def self.method_text_message
	  "text message"
	end
	
	def self.get_recipients(type)
	  recipients = Array.new
	  active_teams = Team.get_active_teams()
	  if type == Administrator.recipient_participant
	    active_teams.each do |team|
	      recipients.push team.participants
	    end
	  elsif type == Administrator.recipient_captain
	    active_teams.each do |team|
        recipients.push team.get_captain()
      end
	  end
	  recipients.flatten
	end
	
	def self.get_message_addresses(users, method_type)
	  addresses = Array.new
	  if method_type == Administrator.method_email
	    accounts = Account.get_accounts(users)
	    accounts.each do |account|
	      addresses.push account.email
	    end
	  elsif method_type == Administrator.method_text_message
	     users.each do |user|
	       addresses.push user.phone_email
	     end
	  end
	  addresses
	end
	
	def self.email(recipients_type, method_type, title, message)
	  recipients = get_recipients(recipients_type)
	  addresses = get_message_addresses(recipients, method_type)
	  AdminMailer.email(addresses, title, message)
	end
end
