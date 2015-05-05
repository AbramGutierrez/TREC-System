require 'nokogiri'
require 'open-uri'
require 'rubygems'

class Participant < ActiveRecord::Base
	belongs_to :team
	has_one :account, :as => :user, dependent: :destroy
	
	validates :account, :team, :phone_email, presence: true
	
	validates :phone, length: {is: 10}, presence: true
	
	validate :phone_email_correct

	validates :shirt_size, presence: true, inclusion: { in: %w(XS S M L XL XXL),
      message: "%{value} is not a valid size, try entering XS, S, M, L, XL, or XXL." }
	  
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
	
	def self.domain(provider)
	  if provider.nil?
	    return nil
	  end
	  
	  providers_list = Participant.get_providers_list()
	  
	  provider_index = providers_list.find_index(provider.downcase)
	  if provider_index.nil?
	    return nil
	  end
	  
	  domain_format = Participant.get_domains_list()[provider_index]
	  Participant.extract_domain(domain_format).strip
	end
	
	def self.create_phone_email(provider, number)
	  if number.nil?
	    number = "XXXXXXXXXX"  # in case user inputs correct provider but incorrect number
	  end
	  
	  domain = Participant.domain(provider)
    if domain.nil?
      return nil
    end
    
    address = number + "@" + domain
	end
	
	private
	
	 def phone_email_correct
	   if !phone_email.nil?
	     split = phone_email.split("@")
	     if split[0] != phone
	       errors.add(self, "phone email number does not match phone number.")
	     end
	   end
	 end
	
		def team_full
			if !team.nil?
				errors.add(:team, "already has the maximum number of participants.") unless
					team.participants.count < team.conference.max_team_size
			end		
		end
end
