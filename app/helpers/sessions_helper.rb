module SessionsHelper

	# Logs in the given account.
	def log_in(account)
		session[:account_id] = account.id
	end
	
	# Returns the current logged-in account (if there is one).
	def current_account
		@currect_account ||= Account.find_by(id: session[:account_id])
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
