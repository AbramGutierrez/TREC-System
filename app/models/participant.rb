require 'nokogiri'
require 'open-uri'
require 'rubygems'

class Participant < ActiveRecord::Base
	belongs_to :team
	has_one :account, :as => :user, dependent: :destroy
	
	validates :phone, :account, :team, presence: true
	validates :shirt_size, presence: true, inclusion: { in: %w(X-small Small Medium Large X-large),
      message: "%{value} is not a valid size, try entering small, medium, or large." }
	  
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
	
	def domain
	  provider = "at&t"
	  providers_list = Participant.get_providers_list()
	  provider_index = providers_list.find_index(provider)
	  
	end
	
	private
	
		def team_full
			if !team.nil?
				errors.add(:team, "already has the maximum number of participants.") unless
					team.participants.count < team.conference.max_team_size
			end		
		end
end
