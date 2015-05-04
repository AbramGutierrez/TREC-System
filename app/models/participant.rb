require 'nokogiri'
require 'open-uri'
require 'rubygems'

class Participant < ActiveRecord::Base
	belongs_to :team
	has_one :account, :as => :user, dependent: :destroy
	
	validates :account, :team, presence: true
	
	validates :phone, length: {is: 10}, presence: true

	validates :shirt_size, presence: true, inclusion: { in: %w(XS S M L XL XXL),
      message: "%{value} is not a valid size, try entering XS, S, M, L, or XL." }
	  
	# Apparently Ruby views nil and false as the same thing, so this only allows captain to be true
	# validates :captain, presence: true
	
	# We could do something like this, but it is not necessary
	validates :captain, inclusion: [true, false]
	
	validate :team_full
	
	accepts_nested_attributes_for :account
	
	def self.get_providers_list
	  page = Nokogiri::HTML(open("http://www.emailtextmessages.com/"))
    providers = page.css('h3')
    providers.map { |provider| provider.text.downcase}
	end
	
	def self.get_domains_list
	  page = Nokogiri::HTML(open("http://www.emailtextmessages.com/"))
    domains = page.css('li')
    domains.map { |domain| domain.text.downcase}
	end
	
	def self.extract_domain(example)
	  split_example = example.partition('@')
	  split_example[2] # should split 3 ways
	end
	
	def domain
	  provider = "at&t"
	  providers_list = Participant.get_providers_list()
	  provider_index = providers_list.find_index(provider)
	  domain_format = Participant.get_domains_list()[provider_index]
	  Participant.extract_domain(domain_format).strip
	end
  
  def self.method_email
    "email"
  end
  
  def self.method_text_message
    "text message"
  end
  
  def self.get_message_addresses(users, method_type)
    addresses = Array.new
    accounts = Account.get_accounts(users)
    accounts.each do |account|
      addresses.push account.email
    end
    addresses
  end
  
  def self.email(method_type, title, message)
    recipients = Team.where(id: team_id).participants
    addresses = get_message_addresses(recipients)
    AdminMailer.email(addresses, title, message)
  end
	
	private
	
		def team_full
			if !team.nil?
				errors.add(:team, "already has the maximum number of participants.") unless
					team.participants.count < team.conference.max_team_size
			end		
		end
end
