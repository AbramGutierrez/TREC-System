module SessionsHelper

	# Logs in the given account.
	def log_in(account)
		session[:account_id] = account.id
	end
	
	# Returns the current logged-in account (if there is one).
	def current_account
		@current_account ||= Account.find_by(id: session[:account_id])
	end
	
	# Returns true if the account passed in is the current account
	def current_account?(account)
		account == current_account
	end
	
	def current_participant
	  if current_account.user.is_a?(Participant)
	    @current_participant ||= current_account.user
	  end		
	end
	
	# Returns true if the participant passed in is the current participant/account
	def current_participant?(participant)
	   participant == current_participant
	end
	
	# Returns true if the account is logged in, false otherwise.
	def logged_in?
		!current_account.nil?
	end
	
	# Returns true if the account is an admin, false otherwise.
	def is_admin?
	    current_account.user.is_a?(Administrator)
	end
	
	# Return true if the account is a participant, false otherwise.
	def is_participant?
	    current_account.user.is_a?(Participant)
	end

	# Return true if the participant is a team captain, false otherwise.
	def is_team_captain?

		if is_participant?
			
			@participant = current_participant

			# check if the participant is a team captain
			if @participant.captain
				true
			else
				# participant is not a team captain
				false
			end

		else
			# account is not a participant
			false
		end

	end
	
	#Logs out the current user.
	def log_out
		session.delete(:account_id)
		@current_account = nil
	end
	
	# Redirects to stored location (or to the default).
    def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end
	
	# Stores the URL trying to be accessed.
    def store_location
      session[:forwarding_url] = request.url if request.get?
    end
end
