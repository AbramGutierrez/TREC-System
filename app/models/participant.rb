require 'nokogiri'
require 'open-uri'
require 'rubygems'

class Participant < ActiveRecord::Base
	belongs_to :team
	has_one :account, :as => :user, dependent: :destroy
	
  accepts_nested_attributes_for :account, :update_only => true
	
	PHONE_REGEX = /\A^[0-9]+$\z/
	validates :phone, length: {is: 10}, format: { with: PHONE_REGEX }, presence: true
	validates :account, :team, :phone_provider, presence: true
	
	validate :phone_provider_correct

	validates :shirt_size, presence: true, inclusion: { in: %w(XS S M L XL XXL),
      message: "%{value} is not a valid size, try entering XS, S, M, L, XL, or XXL." }
	  
	# Apparently Ruby views nil and false as the same thing, so this only allows captain to be true
	# validates :captain, presence: true
	
	# We could do something like this, but it is not necessary
	validates :captain, inclusion: [true, false]
	
	validate :team_full
	
	def self.get_active
	  active_teams = Team.get_active_teams
	  participants = Array.new
	  active_teams.each do |team|
	    participants.append team.participants
	  end
	  return participants.flatten
	end
	
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
	
	 def phone_provider_correct
	   if !phone_provider.nil? && !phone.nil?
	     write_attribute(:phone_email, Participant.create_phone_email(phone_provider, phone))
	     if phone_email.nil?
	       errors.add(:phone_provider, "cannot be found.")
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
